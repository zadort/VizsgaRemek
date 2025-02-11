import React, { useState, useContext } from 'react';
import { Link } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import './Header.css';

function Header({ cart }) {
  const [isProfileMenuOpen, setIsProfileMenuOpen] = useState(false);
  const { isDarkMode, toggleDarkMode } = useContext(DarkModeContext);

  const toggleProfileMenu = () => {
    setIsProfileMenuOpen(!isProfileMenuOpen);
  };

  const closeProfileMenu = () => {
    setIsProfileMenuOpen(false);
  };

  return (
    <header className={isDarkMode ? 'dark-mode' : ''}>
      <div className="logo">Elektronikai Shop</div>
      <div className="search-bar">
        <input type="text" placeholder="Keresés..." />
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
            </div>
          )}
        </div>
      </div>
    </header>
  );
}

export default Header;