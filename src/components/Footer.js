import React from 'react';
import { Link } from 'react-router-dom';

function Footer() {
  return (
    <footer>
      <div className="footer-container">
        <div className="footer-section">
          <h3>Elektronikai Shop</h3>
          <p>&copy; 2024 Elektronikai Shop - Minden jog fenntartva.</p>
        </div>
        <div className="footer-section">
          <h3>Hasznos linkek</h3>
          <ul>
            <li><Link to="/">Kezdőlap</Link></li>
            <li><Link to="#categories">Kategóriák</Link></li>
            <li><Link to="#products">Termékek</Link></li>
            <li><Link to="/kapcsolat">Kapcsolat</Link></li>
            <li><Link to="/adatkezeles">Adatkezelés</Link></li>
            <li><Link to="/aszf">ÁSZF</Link></li>
          </ul>
        </div>
        <div className="footer-section">
          <h3>Elérhetőségek</h3>
          <ul>
            <li>Telefonszám: +36 1 234 5678</li>
            <li>Email: info@elektronikaishop.hu</li>
            <li>Cím: 1234 Budapest, Vásárló utca 1.</li>
          </ul>
        </div>
      </div>
      <div className="footer-bottom">
        <p>Weboldal készítette: Bolgár Milán, Csömör Lajos Marcell, Zádor Tamás</p>
      </div>
    </footer>
  );
}

export default Footer;