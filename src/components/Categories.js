import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom'; // Importáljuk a useNavigate-t
import './Categories.css';

const Categories = ({ cart, updateCart }) => {
    const [categories, setCategories] = useState([]);
    const [selectedCategory, setSelectedCategory] = useState(null);
    const [products, setProducts] = useState([]);
    const [quantities, setQuantities] = useState({});
    const [error, setError] = useState('');
    const navigate = useNavigate(); // Navigációs hook

    // Kategóriák betöltése
    useEffect(() => {
        setCategories(['Notebook', 'Okostelefon', 'Fülhallgató', 'Okosóra', 'Tablet', 'VR Szemüveg']);
    }, []);

    // Termékek betöltése kategória alapján
    const fetchProductsByCategory = async (category) => {
        try {
            const response = await fetch(`http://localhost:5123/Card/category/${category}`);
            if (!response.ok) {
                throw new Error('Hiba a termékek lekérésekor');
            }
            const data = await response.json();
            setProducts(data.products);
            setSelectedCategory(category);
        } catch (error) {
            console.error('Error fetching products:', error);
            setError('Nem sikerült betölteni a termékeket.');
        }
    };

    const handleQuantityChange = (id, value) => {
        setQuantities((prev) => ({
            ...prev,
            [id]: value,
        }));
    };

    const addToCart = (product) => {
        const qty = parseInt(quantities[product.id]) || 1;
        if (qty <= 0) {
            alert('Kérlek, válassz érvényes mennyiséget!');
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
        <div className="categories-container">
            <h1>Kategóriák</h1>
            {error && <p className="error-message">{error}</p>}
            <div className="category-buttons">
                {categories.map((category, index) => (
                    <button
                        key={index}
                        className={`category-button ${selectedCategory === category ? 'active' : ''}`}
                        onClick={() => fetchProductsByCategory(category)}
                    >
                        {category}
                    </button>
                ))}
            </div>

            <div className="products-list">
                {products.map((product) => (
                    <div
                        key={product.id}
                        className="product-card"
                        onClick={() => handleProductClick(product.id)} // Kattintási eseménykezelő
                    >
                        <img src={product.image} alt={product.name} className="product-image" />
                        <h2>{product.name}</h2>
                        <p>Ár: {product.price} Ft</p>
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
                ))}
            </div>
        </div>
    );
};

export default Categories;