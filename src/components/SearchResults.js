import React, { useState, useEffect, useContext } from 'react';
import { useLocation, useNavigate } from 'react-router-dom'; // Importáljuk a useNavigate-t
import { DarkModeContext } from './DarkModeContext';
import './SearchResults.css';

function SearchResults({ cart, updateCart }) {
  const [products, setProducts] = useState([]);
  const [quantities, setQuantities] = useState({});
  const { isDarkMode } = useContext(DarkModeContext);
  const location = useLocation();
  const navigate = useNavigate(); // Navigációs hook
  const query = new URLSearchParams(location.search).get('query');

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await fetch('http://localhost:5123/Card');
        if (!response.ok) {
          throw new Error('Hiba a termékek lekérésekor');
        }
        const data = await response.json();
        if (data.products && Array.isArray(data.products)) {
          const filtered = data.products.filter((product) =>
            product.name.toLowerCase().includes(query.toLowerCase())
          );
          setProducts(filtered);
        } else {
          console.error('A kapott adat nem tartalmaz termékeket:', data);
          throw new Error('A kapott adat nem tartalmaz termékeket');
        }
      } catch (error) {
        console.error('Hiba a termékek lekérésekor:', error);
      }
    };

    if (query) {
      fetchProducts();
    }
  }, [query]);

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

    const productIndex = cart.findIndex((item) => item.name === product.name);
    const newCart = [...cart];

    if (productIndex === -1) {
      newCart.push({ name: product.name, price: product.price, quantity: qty });
    } else {
      newCart[productIndex].quantity += qty;
    }

    updateCart(newCart);
  };

  const handleProductClick = (id) => {
    navigate(`/product/${id}`); // Navigálás a termék részletes oldalára
  };

  return (
    <div className={`search-results-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <h1 className="search-results-title">Keresési eredmények: "{query}"</h1>
      <div className="products-container">
        {products.length > 0 ? (
          products.map((product) => (
            <div 
              className={`product-card ${isDarkMode ? 'dark-mode' : ''}`} 
              key={product.id}
              onClick={() => handleProductClick(product.id)} // Kattintási eseménykezelő
            >
              <div className="product-content">
                <img src={product.image} alt={product.name} className="product-image" />
                <div className="product-details">
                  <h2 className="product-name">{product.name}</h2>
                  <p className="product-price">Ár: {product.price} Ft</p>
                </div>
              </div>
              <div className="product-actions" onClick={(e) => e.stopPropagation()}>
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
          ))
        ) : (
          <p className="no-results">Nincs találat.</p>
        )}
      </div>
    </div>
  );
}

export default SearchResults;