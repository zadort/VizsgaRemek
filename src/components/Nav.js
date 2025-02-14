import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import './Nav.css';

function Nav() {
  const location = useLocation();

  return (
    <nav className="navbar">
      <div className="nav-links">
        <Link 
          to="/" 
          className={location.pathname === "/" ? "nav-link active" : "nav-link"}
        >
          Kezdőlap
        </Link>
        <Link 
          to="#categories" 
          className="nav-link"
        >
          Kategóriák
        </Link>
        <Link 
          to="/products" 
          className={location.pathname === "/products" ? "nav-link active" : "nav-link"}
        >
          Termékek
        </Link>
        <Link 
          to="/kapcsolat" 
          className={location.pathname === "/kapcsolat" ? "nav-link active" : "nav-link"}
        >
          Kapcsolat
        </Link>
      </div>
    </nav>
  );
}

export default Nav;