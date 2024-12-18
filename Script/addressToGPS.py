from geopy.geocoders import Nominatim
import sys

def address_to_coordinates(address):
    geolocator = Nominatim(user_agent="addressToGPS")
    location = geolocator.geocode(address)
    if location:
        return (location.latitude, location.longitude)
    else:
        return None

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 script.py 'adresse complète'")
        sys.exit(1)
    address = " ".join(sys.argv[1:])

    coordinates = address_to_coordinates(address)
    if coordinates:
        print(f"Coordinates for {address}: {coordinates}")
    else:
        print(f"Failed to geocode address: {address}")