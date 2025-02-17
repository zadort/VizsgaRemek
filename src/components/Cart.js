import React, { useContext } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { DarkModeContext } from './DarkModeContext';
import './Cart.css';

function Cart({ cart, updateCart }) {
  const { isDarkMode } = useContext(DarkModeContext);
  const navigate = useNavigate();

  const removeFromCart = (itemName) => {
    const newCart = cart.filter(item => item.nev !== itemName);
    updateCart(newCart);
  };

  const updateQuantity = (itemName, newQuantity) => {
    const newCart = cart.map(item => 
      item.nev === itemName ? { ...item, quantity: parseInt(newQuantity) } : item
    );
    updateCart(newCart);
  };

  const calculateTotal = () => {
    return cart.reduce((total, item) => total + item.ar * item.quantity, 0);
  };

  const handleCheckout = () => {
    const total = calculateTotal();
    navigate('/checkout', { state: { cart, total } }); // Az adatokat itt adja át
  };

  return (
    <div className={isDarkMode ? 'dark-mode' : ''}>
      <div className="hero">
        <h1>Kosár tartalma</h1>
      </div>
      <main>
        <section className="cart-container">
          {cart.length === 0 ? (
            <p>A kosár üres.</p>
          ) : (
            cart.map((item, index) => (
              <div className={`cart-item ${isDarkMode ? 'dark-mode' : ''}`} key={index}>
                <h2>{item.nev}</h2>
                <p>{item.ar} Ft</p>
                <label htmlFor={`quantity-${item.nev}`}>Mennyiség:</label>
                <input
                  type="number"
                  id={`quantity-${item.nev}`}
                  value={item.quantity}
                  min="1"
                  onChange={(e) => updateQuantity(item.nev, e.target.value)}
                />
                <button className="remove-btn" onClick={() => removeFromCart(item.nev)}>
                  Eltávolítás
                </button>
              </div>
            ))
          )}
        </section>
        <div className="total">Összesen: {calculateTotal()} Ft</div>
        <div className="button-container">
          <Link to="/" className="btn">Tovább a vásárláshoz</Link>
          <button className="btn" onClick={handleCheckout}>Vásárlás</button>
        </div>
      </main>
    </div>
  );
}

export default Cart;
