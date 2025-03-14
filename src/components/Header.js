import React, { useState, useContext, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import { useAuth } from './AuthContext';
import './Header.css';

function Header({ cart }) {
  const [isProfileMenuOpen, setIsProfileMenuOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [filteredProducts, setFilteredProducts] = useState([]);
  const [isSearchFocused, setIsSearchFocused] = useState(false);
  const { isDarkMode, toggleDarkMode } = useContext(DarkModeContext);
  const { isLoggedIn, logout } = useAuth();
  const navigate = useNavigate();

  const [products, setProducts] = useState([]);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await fetch('http://localhost:5123/Card');
        const data = await response.json();
        if (Array.isArray(data.products)) {
          setProducts(data.products);
        } else {
          console.error('Unexpected response format:', data);
        }
      } catch (error) {
        console.error('Hiba a termékek betöltésekor:', error);
      }
    };

    fetchProducts();
  }, []);

  useEffect(() => {
    if (searchTerm) {
      const filtered = products.filter((product) =>
        product.name.toLowerCase().includes(searchTerm.toLowerCase())
      );
      setFilteredProducts(filtered);
    } else {
      setFilteredProducts([]);
    }
  }, [searchTerm, products]);

  const handleSearchChange = (e) => {
    setSearchTerm(e.target.value);
  };

  const handleSearchFocus = () => {
    setIsSearchFocused(true);
  };

  const handleSearchBlur = () => {
    setTimeout(() => setIsSearchFocused(false), 200);
  };

  const handleSearchSubmit = () => {
    if (searchTerm.trim()) {
      navigate(`/search?query=${encodeURIComponent(searchTerm)}`);
      setSearchTerm('');
      setFilteredProducts([]);
    }
  };

  const handleProductClick = (productId) => {
    navigate(`/product/${productId}`);
    setSearchTerm('');
    setFilteredProducts([]);
  };

  const toggleProfileMenu = () => {
    setIsProfileMenuOpen(!isProfileMenuOpen);
  };

  const closeProfileMenu = () => {
    setIsProfileMenuOpen(false);
  };

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  return (
    <header className={isDarkMode ? 'dark-mode' : ''}>
      <div className="logo">Elektronikai Shop</div>
      <div className="search-bar">
        <input
          type="text"
          placeholder="Keresés..."
          value={searchTerm}
          onChange={handleSearchChange}
          onFocus={handleSearchFocus}
          onBlur={handleSearchBlur}
        />
        <button className="search-button" onClick={handleSearchSubmit}>
          <i className="fas fa-search"></i>
        </button>
        {isSearchFocused && filteredProducts.length > 0 && (
          <div className="search-results">
            {filteredProducts.map((product) => (
              <div
                key={product.id}
                className="search-result-item"
                onClick={() => handleProductClick(product.id)}
              >
                {product.name} - {product.price} Ft
              </div>
            ))}
          </div>
        )}
      </div>
      <div className="cart-profile">
        <div className="cart">
          <Link to="/cart">
            <i className="fas fa-shopping-cart"></i>
            <span id="cart-count">Kosár ({cart.length})</span>
          </Link>
        </div>
        <button className="dark-mode-toggle" onClick={toggleDarkMode}>
          {isDarkMode ? '🌙' : '☀️'}
        </button>
        <div className="profile" onClick={toggleProfileMenu}>
          <i className="fas fa-user" id="profile-icon"></i>
          {isProfileMenuOpen && (
            <div className="profile-menu active">
              {isLoggedIn ? (
                <>
                  <Link
                    to="/profile"
                    className="profile-menu-item"
                    onClick={(e) => {
                      e.stopPropagation();
                      closeProfileMenu();
                    }}
                  >
                    Profil
                  </Link>
                  <button
                    className="profile-menu-item"
                    onClick={(e) => {
                      e.stopPropagation();
                      handleLogout();
                      closeProfileMenu();
                    }}
                  >
                    Kijelentkezés
                  </button>
                </>
              ) : (
                <>
                  <Link
                    to="/login"
                    className="profile-menu-item"
                    onClick={(e) => {
                      e.stopPropagation();
                      closeProfileMenu();
                    }}
                  >
                    Bejelentkezés
                  </Link>
                  <Link
                    to="/register"
                    className="profile-menu-item"
                    onClick={(e) => {
                      e.stopPropagation();
                      closeProfileMenu();
                    }}
                  >
                    Regisztráció
                  </Link>
                </>
              )}
            </div>
          )}
        </div>
      </div>
    </header>
  );
}

export default Header;