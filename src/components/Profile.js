import React, { useState, useEffect } from 'react';
import { useAuth } from './AuthContext';
import { useNavigate } from 'react-router-dom';
import { jwtDecode } from 'jwt-decode';
import './Profile.css';

function Profile() {
    const { isLoggedIn, logout } = useAuth();
    const [username, setUsername] = useState('');
    const [email, setEmail] = useState('');
    const [newUsername, setNewUsername] = useState('');
    const [newEmail, setNewEmail] = useState('');
    const [newPassword, setNewPassword] = useState('');
    const [error, setError] = useState('');
    const [successMessage, setSuccessMessage] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        if (!isLoggedIn) {
            navigate('/login');
            return;
        }

        const fetchUserData = async () => {
            try {
                const token = localStorage.getItem('token');
                if (!token) {
                    throw new Error('Hiányzó token. Kérjük, jelentkezzen be újra.');
                }

                const decodedToken = jwtDecode(token);
                const userId = decodedToken.sub;

                const response = await fetch(`http://localhost:5123/User/${userId}`, {
                    method: 'GET',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                    },
                });

                if (!response.ok) {
                    if (response.status === 401) {
                        logout();
                        navigate('/login');
                        return;
                    }
                    const errorData = await response.json();
                    throw new Error(errorData.message || 'Hiba a felhasználói adatok lekérésekor.');
                }

                const data = await response.json();
                console.log('Lekért adatok:', data); // Ellenőrizd a backend válaszát
                setUsername(data.username || 'Nincs megadva');
                setEmail(data.email || 'Nincs megadva');
                setNewUsername(data.username || '');
                setNewEmail(data.email || '');
                setError('');
            } catch (error) {
                console.error('Error fetching user data:', error);
                setError(error.message || 'Hiba történt a felhasználói adatok betöltésekor.');
            }
        };

        fetchUserData();
    }, [isLoggedIn, navigate, logout]);

    const handleUpdateProfile = async (e) => {
        e.preventDefault();

        try {
            const token = localStorage.getItem('token');
            if (!token) {
                throw new Error('Hiányzó token. Kérjük, jelentkezzen be újra.');
            }

            const decodedToken = jwtDecode(token);
            const userId = decodedToken.sub;

            const response = await fetch(`http://localhost:5123/User/${userId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`,
                },
                body: JSON.stringify({
                    username: newUsername || username,
                    email: newEmail || email,
                    password: newPassword || undefined,
                }),
            });

            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.message || 'Hiba történt a profil frissítésekor.');
            }

            const updatedData = await response.json();
            setSuccessMessage('Profil sikeresen frissítve!');
            setError('');
            setUsername(updatedData.username);
            setEmail(updatedData.email);
            setNewUsername('');
            setNewEmail('');
            setNewPassword('');
        } catch (error) {
            console.error('Error updating profile:', error);
            setError(error.message || 'Hiba történt a profil frissítésekor.');
            setSuccessMessage('');
        }
    };

    return (
        <div className="profile-container">
            <h2>Profil</h2>
            {error && <div className="error-message">{error}</div>}
            {successMessage && <div className="success-message">{successMessage}</div>}
            <form onSubmit={handleUpdateProfile}>
                <div className="form-group">
                    <label htmlFor="username">Felhasználónév</label>
                    <input
                        type="text"
                        id="username"
                        value={newUsername}
                        onChange={(e) => setNewUsername(e.target.value)}
                        placeholder={username || 'Új felhasználónév'}
                    />
                </div>
                <div className="form-group">
                    <label htmlFor="email">Email</label>
                    <input
                        type="email"
                        id="email"
                        value={newEmail}
                        onChange={(e) => setNewEmail(e.target.value)}
                        placeholder={email || 'Új email cím'}
                    />
                </div>
                <div className="form-group">
                    <label htmlFor="password">Új jelszó</label>
                    <input
                        type="password"
                        id="password"
                        value={newPassword}
                        onChange={(e) => setNewPassword(e.target.value)}
                        placeholder="Új jelszó"
                    />
                </div>
                <button type="submit" className="btn btn-primary">
                    Módosítás
                </button>
            </form>
            <button className="btn btn-danger mt-3" onClick={logout}>
                Kijelentkezés
            </button>
        </div>
    );
}

export default Profile;