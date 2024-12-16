from geopy.geocoders import Nominatim

def address_to_coordinates(address):
    geolocator = Nominatim(user_agent="addressToGPS")
    location = geolocator.geocode(address)
    if location:
        return (location.latitude, location.longitude)
    else:
        return None

if __name__ == "__main__":
    address = "750 font bvd, San Francisco, CA 94132"
    coordinates = address_to_coordinates(address)
    if coordinates:
        print(f"Coordinates for {address}: {coordinates}")
    else:
        print(f"Failed to geocode address: {address}")