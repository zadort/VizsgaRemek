import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import './Nav.css';

function Nav() {
  const location = useLocation();
  const [menuOpen, setMenuOpen] = useState(false);

  const toggleMenu = () => {
    setMenuOpen(!menuOpen);
  };

  return (
    <nav className="navbar">
      <button className="hamburger" onClick={toggleMenu} aria-label="Menü">
        ☰
      </button>

      <div className={`nav-links ${menuOpen ? 'active' : ''}`}>
        <Link
          to="/"
          className={location.pathname === '/' ? 'nav-link active' : 'nav-link'}
          onClick={() => setMenuOpen(false)}
        >
          Kezdőlap
        </Link>
        <Link
          to="/categories"
          className={location.pathname === '/categories' ? 'nav-link active' : 'nav-link'}
          onClick={() => setMenuOpen(false)}
        >
          Kategóriák
        </Link>
        <Link
          to="/products"
          className={location.pathname === '/products' ? 'nav-link active' : 'nav-link'}
          onClick={() => setMenuOpen(false)}
        >
          Termékek
        </Link>
        <Link
          to="/kapcsolat"
          className={location.pathname === '/kapcsolat' ? 'nav-link active' : 'nav-link'}
          onClick={() => setMenuOpen(false)}
        >
          Kapcsolat
        </Link>
      </div>
    </nav>
  );
}

export default Nav;