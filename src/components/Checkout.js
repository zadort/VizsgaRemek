import React from 'react';
import { PayPalScriptProvider, PayPalButtons } from '@paypal/react-paypal-js';
import { useNavigate, useLocation } from 'react-router-dom';
import './Checkout.css';

const Checkout = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const { cart, total } = location.state || { cart: [], total: 0 };

  const createOrder = (data, actions) => {
    console.log('createOrder', data, actions);
    return actions.order.create({
      purchase_units: [
        {
          amount: {
            value: total.toFixed(2),
            currency_code: 'HUF',
          },
        },
      ],
    }).catch(error => {
      console.error("Order creation error:", error);
      alert('Hiba történt a rendelés létrehozásakor.');
    });
  };

  const onApprove = (data, actions) => {
    console.log('onApprove', data);
    return actions.order.capture().then((details) => {
      console.log('Fizetés sikeres:', details);
      alert('Fizetés sikeres! Köszönjük a vásárlást.');
      navigate('/');
    }).catch(error => {
      console.error('PayPal hiba:', error);
      alert('Hiba történt a fizetés feldolgozása közben. Kérjük, próbálja újra.');
    });
  };

  const handleError = (error) => {
    console.error('PayPal Error:', error);
    alert('Hiba történt a PayPal folyamat közben. Kérjük, próbálja újra.');
  };

  return (
    <div className="checkout-container">
      <h1>Fizetés</h1>
      <div className="cart-summary">
        <h2>Kosár tartalma</h2>
        {cart.map((item, index) => (
          <div key={index} className="cart-item">
            <p>{item.nev} - {item.quantity} db - {item.ar * item.quantity} Ft</p>
          </div>
        ))}
        <h3>Összesen: {total} Ft</h3>
      </div>
      <div className="payment-methods">
        <h2>Fizetési módok</h2>
        <PayPalScriptProvider options={{ 'client-id': 'ARKb7iTQY6kcmxx3ms4a5j67y76p1dCw-mOTxFWdTam5cUj_zFfLdt1PCeHwFa9NRSSzCs8exmsCLLam' }}>
          <PayPalButtons
            createOrder={createOrder}
            onApprove={onApprove}
            onError={handleError}
            style={{ layout: 'vertical', shape: 'rect', color: 'blue' }}
          />
        </PayPalScriptProvider>
      </div>
    </div>
  );
};

export default Checkout;
