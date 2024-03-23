# Flutter App Project: Mystery Dining Edition

## Overview

Mystery Dining Edition is a Flutter-based mobile application designed to offer users unique dining experiences by leveraging the Yelp Fusion API. The app introduces users to mystery dining spots based on their preferences, adding an element of surprise and discovery to their culinary adventures.

### Features

- **Mystery Search**: Users can input their dining preferences to discover a mystery dining spot, revealed in an engaging manner.
- **Culinary Roulette**: An interactive feature that suggests random restaurants based on the user's location and preferences.
- **Adventure Log**: Users can keep track of their dining adventures, including reviews and ratings of the surprise factor.
- **Themed Adventures**: Offers specially curated dining experiences, like "Wizarding Feasts" or "Superhero Snacks," for those seeking themed dining options.

## Setup Instructions

### Prerequisites

- Flutter SDK
- Android Studio or Visual Studio Code
- A valid Yelp Fusion API key

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/ologunB/ruvik_app.git
2. **Navigate to the project directory:**
   ```bash
   cd {FOLDER_DIR}/ruvik_app
3. **Install dependencies:**
   ```bash
   flutter pub get
4. **Add your Yelp API Key:**

Open `lib/views/widgets/utils.dart` and replace `YOUR_YELP_API_KEY` with your actual Yelp Fusion API key.
```dart
const String yelpToken = 'YOUR_YELP_API_KEY';
```


###  Run the app:
   ```bash
    flutter run
```
### Using the App
- Start by setting your dining preferences in the Mystery Search to get personalized restaurant suggestions.
- Spin the Culinary Roulette for spontaneous dining options.
- Log your adventures and share your experiences with the community.
- Explore themed adventures for a curated dining experience like no other.

### Yelp API
# Yelp API Integration in Mystery Dining Edition

## Overview

The `RestaurantsApi` class in our Flutter application serves as the bridge between the Mystery Dining Edition app and the Yelp Fusion API. It encapsulates all interactions with the API, fetching data that powers the app's core features. Below is a detailed explanation of each method within this class and how they leverage the Yelp API.

## Methods

### 1. `getAll()`

#### Purpose
Fetches a list of restaurants based on user preferences such as category, location, and availability.

#### Yelp API Endpoint
`businesses/search`

#### Implementation
- Retrieves filter criteria from the app's cache.
- Constructs a query with parameters (`term`, `limit`, `open_now`, `location`, `categories`).
- Sends a `GET` request to Yelp, processing the response into a list of `RestaurantModel`.

### 2. `getThemed(Map<String, dynamic> data)`

#### Purpose
Retrieves themed restaurant suggestions by applying filters from the `data` parameter.

#### Yelp API Endpoint
`businesses/search`

#### Implementation
- Enhances the provided `data` with the user's location.
- Queries the Yelp API with tailored parameters from `data`.
- Processes the response, returning a list of `RestaurantModel` for themed dining spots.

### 3. `getDetails(String? id)`

#### Purpose
Obtains detailed information about a specific restaurant using its Yelp business ID.

#### Yelp API Endpoint
`/businesses/{id}`

#### Implementation
- Builds the endpoint URL with the provided ID.
- Fetches and returns detailed restaurant data as a `RestaurantModel`.

### 4. `getReviews(String? id)`

#### Purpose
Gathers user reviews for a specified restaurant.

#### Yelp API Endpoint
`businesses/{id}/reviews`

#### Implementation
- Uses the restaurant's ID to construct the request URL.
- Specifies request parameters to refine the reviews fetched.
- Converts the response into a list of `ReviewModel` instances.

### 5. `getCategories()`

#### Purpose
Fetches a comprehensive list of restaurant categories from Yelp, aiding in search filters.

#### Yelp API Endpoint
`categories`

#### Implementation
- Requests the full list of categories via a simple `GET` call.
- Parses the response, offering a list of `Categories` instances for app filters.

## Integration and Usage

The `RestaurantsApi` class is integral to the app, enabling direct access to Yelp's dataset for features like Mystery Search, Culinary Roulette, and Themed Adventures. This abstraction not only simplifies Yelp API interactions but also enriches the user experience by seamlessly providing relevant, user-tailored dining suggestions.

### Contribution
We welcome contributions to improve Mystery Dining Edition! Please feel free to fork the repository, make your changes, and submit a pull request.

### License
This project is licensed under the MIT License - see the LICENSE.md file for details.

This Markdown-formatted README file provides a structured overview of your project, including an introduction, features list, setup instructions, and additional information on contributing and licensing. Adjust the content as necessary to fit your project's specifics.








