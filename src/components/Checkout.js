import React, { useState } from 'react';
import { PayPalScriptProvider, PayPalButtons } from '@paypal/react-paypal-js';
import { useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from './AuthContext'; // Importáljuk az AuthContext-et
import './Checkout.css';

const Checkout = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const { cart, total } = location.state || { cart: [], total: 0 };
  const [isProcessing, setIsProcessing] = useState(false);
  const { isLoggedIn } = useAuth(); // Ellenőrizzük, hogy be van-e jelentkezve

  const createOrder = (data, actions) => {
    return actions.order.create({
      purchase_units: [
        {
          amount: {
            value: total.toFixed(2),
            currency_code: 'HUF',
          },
        },
      ],
    }).catch((error) => {
      console.error('Order creation error:', error);
      alert('Hiba történt a rendelés létrehozásakor.');
    });
  };

  const onApprove = (data, actions) => {
    setIsProcessing(true);
    return actions.order.capture().then((details) => {
      alert(`Fizetés sikeres! Köszönjük a vásárlást, ${details.payer.name.given_name}!`);
      navigate('/');
    }).catch((error) => {
      console.error('PayPal hiba:', error);
      alert('Hiba történt a fizetés feldolgozása közben. Kérjük, próbálja újra.');
    }).finally(() => {
      setIsProcessing(false);
    });
  };

  const handleError = (error) => {
    console.error('PayPal Error:', error);
    alert('Hiba történt a PayPal folyamat közben. Kérjük, próbálja újra.');
  };

  return (
    <div className="checkout-container">
      <div className="checkout-header">
        <h1>Fizetés</h1>
        <p>Véglegesítsd a rendelésed és fizess biztonságosan a PayPal segítségével.</p>
      </div>

      <div className="cart-summary">
        <h2>Kosár tartalma</h2>
        {cart.length > 0 ? (
          cart.map((item, index) => (
            <div key={index} className="cart-item">
              <div className="cart-item-details">
                <span className="cart-item-name">{item.name}</span>
                <span className="cart-item-quantity">{item.quantity} db</span>
                <span className="cart-item-price">{item.price * item.quantity} Ft</span>
              </div>
            </div>
          ))
        ) : (
          <p className="empty-cart-message">A kosár üres.</p>
        )}
        <div className="cart-total">
          <h3>Összesen:</h3>
          <p>{total.toLocaleString()} Ft</p>
        </div>
      </div>

      <div className="paypal-container">
        {isLoggedIn ? (
          <PayPalScriptProvider options={{ 'client-id': 'AYQxMUbBjGmkEPWkbPd0VzOskTtk1RYudk-oGJ1I-8EjMaR9b089AGuVwtafKj-vYBthb5xO5_kdikSZ' }}>
            <PayPalButtons
              createOrder={createOrder}
              onApprove={onApprove}
              onError={handleError}
              style={{ layout: 'vertical', shape: 'rect', color: 'blue' }}
            />
          </PayPalScriptProvider>
        ) : (
          <p className="login-warning">A fizetéshez kérjük, jelentkezz be!</p>
        )}
      </div>

      <div className="checkout-footer">
        <button className="back-to-cart-btn" onClick={() => navigate('/cart')}>
          Vissza a kosárhoz
        </button>
        {isProcessing && <p className="processing-message">Fizetés feldolgozása...</p>}
      </div>
    </div>
  );
};

export default Checkout;