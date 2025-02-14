import React, { useContext } from 'react';
import { DarkModeContext } from './DarkModeContext';
import './Checkout.css';

function Checkout() {
  const { isDarkMode } = useContext(DarkModeContext);

  const handleSubmit = (e) => {
    e.preventDefault();
    alert('Vásárlás sikeresen rögzítve!');
  };

  return (
    <div className={isDarkMode ? 'dark-mode' : ''}>
      <div className="hero">
        <h1>Vásárlás</h1>
      </div>
      <main>
        <section className="checkout-container">
          <form onSubmit={handleSubmit}>
            <div className="form-group">
              <label htmlFor="name">Név:</label>
              <input type="text" id="name" required />
            </div>
            <div className="form-group">
              <label htmlFor="email">Email:</label>
              <input type="email" id="email" required />
            </div>
            <div className="form-group">
              <label htmlFor="address">Cím:</label>
              <input type="text" id="address" required />
            </div>
            <div className="form-group">
              <label htmlFor="phone">Telefonszám:</label>
              <input type="tel" id="phone" required />
            </div>
            <button type="submit" className="btn">Vásárlás véglegesítése</button>
          </form>
        </section>
      </main>
    </div>
  );
}

export default Checkout;