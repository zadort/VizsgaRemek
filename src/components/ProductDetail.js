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
        const response = await fetch(`http://localhost:5123/Card/${id}`);
        if (!response.ok) {
          throw new Error('Hiba a termék lekérésekor');
        }
        const data = await response.json();
        console.log('Fetched product data:', data); // Debugging information
        setProduct(data.product);
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
    addToCart(product.name, product.price, quantity);
  };

  if (error) {
    return <div className="error-message">{error}</div>;
  }

  if (!product) {
    return <div>Betöltés...</div>;
  }

  // Debugging information
  console.log('Product:', product);
  console.log('Product Name:', product.name);
  console.log('Product Price:', product.price);
  console.log('Product Description:', product.description);
  console.log('Product Image:', product.image);

  return (
    <div className="product-detail">
      <div className="product-image-container">
        {product.image ? (
          <img src={product.image} alt={product.name} className="product-image" onError={(e) => e.target.src = 'path/to/default-image.jpg'} />
        ) : (
          <div className="no-image">Nincs kép</div>
        )}
      </div>
      <div className="product-info">
        <h1 className="product-name">{product.name}</h1>
        <p className="product-price">{product.price} Ft</p>
        <p className="product-description">{product.description}</p>

        {/* Műszaki adatok rész */}
        {product.specs && (
          <div className="product-specs">
            <h2 className="specs-title">Műszaki adatok</h2>
            <div className="specs-content">
              {product.specs.split('\n').map((line, index) => (
                <p key={index} className="specs-line">{line}</p>
              ))}
            </div>
          </div>
        )}

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