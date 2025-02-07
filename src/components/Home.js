import React, { useState, useEffect, useContext } from 'react';
import { DarkModeContext } from './DarkModeContext';
import './Home.css';

function Home({ cart, updateCart }) {
  const [products, setProducts] = useState([]);
  const { isDarkMode } = useContext(DarkModeContext);

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

  const addToCart = (nev, ar, qty) => {
    qty = parseInt(qty);
    if (isNaN(qty) || qty <= 0) {
      alert("Kérlek, válassz érvényes mennyiséget!");
      return;
    }

    const productIndex = cart.findIndex(item => item.nev === nev);
    const newCart = [...cart];
    if (productIndex === -1) {
      newCart.push({ nev, ar, quantity: qty });
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
        {products.map((product, index) => (
          <div className={`product-card ${isDarkMode ? 'dark-mode' : ''}`} key={index}>
            <img src={product.kepUrl} alt={product.nev} className="product-image" />
            <div className="product-details">
              <h2 className="product-name">{product.nev}</h2>
              <p className="product-price">Ár: {product.ar} Ft</p>
              <div className="product-actions">
                <input
                  type="number"
                  id={`${product.nev}-qty`}
                  defaultValue="1"
                  min="1"
                  className="quantity-input"
                />
                <button
                  className="add-to-cart-btn"
                  onClick={() => addToCart(product.nev, product.ar, document.getElementById(`${product.nev}-qty`).value)}
                >
                  Kosárba
                </button>
              </div>
            </div>
          </div>
        ))}
      </section>
    </div>
  );
}

export default Home;