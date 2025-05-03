This is a coding assessment for mobile developers applying to work on real-time collaborative features in a Flutter application. The project simulates a feature that allows users to invite a friend and shop together via a shared cart experience.
— 
## 🎯 Objective
Implement the **Shop With Friends** flow using Flutter. A user should be able to:
- Create a shopping session and invite a friend via a link
- The friend joins the session, temporarily enters a shared cart state
- Both users can add items to the cart, which syncs in real-time or via simulation
- Once done, the friend exits the shared state, and the original user continues


This Flutter project follows a modular and feature-first architecture, organized for scalability and maintainability. Here's a breakdown of the structure:


Run command

Flutter pub get 
Flutter run


✅ Core Module (lib/core)
Contains global configurations and setup files:

app_theme.dart: Centralized theme and styling configuration.

app_colors.dart: Custom color palette.

app_routes.dart: App-wide route management.

get_it_setup.dart: Service locator for dependency injection.

firebase_auth_service.dart, firestore_service.dart: Abstractions for Firebase operations.

✅ Features Module (lib/features)
Divided by business domains. Each feature contains data, presentation, and provider layers.

🔐 Auth
data: Placeholder for future data logic.

presentation/pages: login_page.dart, sign_up_page.dart.

provider: Manages authentication state (auth_provider.dart).

🛒 Cart
data: Data-related classes or services.

presentation/pages: Contains cart_page.dart.

provider: Cart state management (cart_provider.dart).

🏠 Homepage
data/models: Domain models like Beverage and ShoppingInvite.

repositories: Business logic layer (invite_repository.dart).

presentation/pages: Includes tabbed navigation (cart_tabbar.dart, favorite_tabbar.dart, home_tabbar.dart, invite_tabbar.dart), and pages like home_page.dart, confirmation_page.dart.

provider: Invite-related state management (invite_provider.dart).

🛍️ Product
data/model: Product model definition.

repository: Business logic (product_repository.dart).

presentation/pages: Product UI (product_page.dart).

provider: Product state provider (product_provider.dart).

🧩 Shared Components
utils: Utilities like dialog handling, date formatting, and navigation helpers.

widgets: Custom widgets used across the app.

services: Firebase and notification service configuration files.

main.dart, wrapper.dart: App entry point and navigation wrapper.