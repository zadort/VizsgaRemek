import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import './ProductDetail.css';

function ProductDetail({ addToCart }) {
  const { id } = useParams();
  const [product, setProduct] = useState(null);
  const [quantity, setQuantity] = useState(1);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchProduct = async () => {
      try {
        const response = await fetch(`https://localhost:7051/Kartya/${id}`);
        if (!response.ok) {
          throw new Error('Hiba a termék lekérésekor');
        }
        const data = await response.json();
        setProduct(data);
        setError(null); // Reset error state if data fetch is successful
      } catch (error) {
        console.error('Hiba a termék lekérésekor:', error);
        setError('Sajnáljuk, nem sikerült betölteni a terméket.');
      }
    };

    fetchProduct();
  }, [id]);

  const handleAddToCart = () => {
    if (quantity <= 0 || isNaN(quantity)) {
      alert("Kérlek, válassz érvényes mennyiséget!");
      return;
    }
    addToCart(product.nev, product.ar, quantity);
  };

  if (error) {
    return <div className="error-message">{error}</div>;
  }

  if (!product) {
    return <div>Betöltés...</div>;
  }

  return (
    <div className="product-detail">
      <div className="product-image-container">
        <img src={product.kepUrl} alt={product.nev} className="product-image" />
      </div>
      <div className="product-info">
        <h1 className="product-name">{product.nev}</h1>
        <p className="product-price">{product.ar} Ft</p>
        <p className="product-description">{product.leiras}</p>
        <div className="product-actions">
          <input
            type="number"
            value={quantity}
            min="1"
            onChange={(e) => setQuantity(parseInt(e.target.value))}
            className="quantity-input"
            aria-label="Mennyiség"
          />
          <button 
            className="add-to-cart-btn" 
            onClick={handleAddToCart}
            aria-label="Hozzáadás a kosárhoz"
          >
            Kosárba <span className="cart-icon">🛒</span>
          </button>
        </div>
      </div>
    </div>
  );
}

export default ProductDetail;
