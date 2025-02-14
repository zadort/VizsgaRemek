import React, { useState, useEffect, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import './Home.css';

function Home({ cart, updateCart }) {
  const [products, setProducts] = useState([]);
  const { isDarkMode } = useContext(DarkModeContext);
  const navigate = useNavigate();
  const [quantities, setQuantities] = useState({});

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await fetch('https://localhost:7051/Kartya');
        if (!response.ok) {
          throw new Error('Hiba a termékek lekérésekor');
        }
        const data = await response.json();
        setProducts(data);
      } catch (error) {
        console.error('Hiba a termékek lekérésekor:', error);
      }
    };

    fetchProducts();
  }, []);

  const handleProductClick = (id) => {
    navigate(`/product/${id}`);
  };

  const handleQuantityChange = (id, value) => {
    setQuantities((prev) => ({
      ...prev,
      [id]: value,
    }));
  };

  const addToCart = (product) => {
    const qty = parseInt(quantities[product.id]) || 1;
    if (qty <= 0) {
      alert("Kérlek, válassz érvényes mennyiséget!");
      return;
    }

    const productIndex = cart.findIndex((item) => item.nev === product.nev);
    const newCart = [...cart];

    if (productIndex === -1) {
      newCart.push({ nev: product.nev, ar: product.ar, quantity: qty });
    } else {
      newCart[productIndex].quantity += qty;
    }

    updateCart(newCart);
  };

  return (
    <div className={`home-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <div className="hero">
        <h1>Üdvözlünk az Elektronikai Shopban!</h1>
        <p>Találd meg a legjobb eszközöket és kiegészítőket!</p>
      </div>
      <section className="products-container">
        {products.map((product) => (
          <div 
            className={`product-card ${isDarkMode ? 'dark-mode' : ''}`} 
            key={product.id} 
          >
            <div className="product-content" onClick={() => handleProductClick(product.id)}>
              <img src={product.kepUrl} alt={product.nev} className="product-image" />
              <div className="product-details">
                <h2 className="product-name">{product.nev}</h2>
                <p className="product-price">Ár: {product.ar} Ft</p>
              </div>
            </div>
            <div className="product-actions">
              <input
                type="number"
                value={quantities[product.id] || 1}
                min="1"
                onChange={(e) => handleQuantityChange(product.id, e.target.value)}
                className="quantity-input"
              />
              <button className="add-to-cart-btn" onClick={() => addToCart(product)}>
                Kosárba<span className="cart-icon">🛒</span>
              </button>
            </div>
          </div>
        ))}
      </section>
    </div>
  );
}

export default Home;
