import React, { useState, useEffect } from 'react';
import { useAuth } from './AuthContext';

const Profile = () => {
  const { currentUser } = useAuth();
  const [userData, setUserData] = useState(null);

  useEffect(() => {
    if (currentUser) {
      fetch(`https://localhost:7051/Felhasznalo/profile/${currentUser.username}`)
        .then((response) => response.json())
        .then((data) => setUserData(data))
        .catch((error) => console.error('Error fetching user profile:', error));
    }
  }, [currentUser]);

  if (!currentUser) {
    return <div>Please log in to view your profile.</div>;
  }

  return (
    <div>
      <h2>Profile</h2>
      {userData ? (
        <div>
          <p>Username: {userData.username}</p>
          <p>Email: {userData.email}</p>
        </div>
      ) : (
        <p>Loading...</p>
      )}
    </div>
  );
};

export default Profile;
