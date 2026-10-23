//
//  coordinator.swift
//  EcommerceApp
//
//  Created by rania on 17/10/2026.
//

import SwiftUI
import Observation

// MARK: - 1. Home Flow Routes
/// Defines every navigation destination reachable within the Home flow.
enum HomeRoute: Hashable, Identifiable {
    case productDetails(ProductModel)
    case filter

    var id: String {
        switch self {
        case .productDetails(let product):
            return "productDetails_\(product.id.uuidString)"
        case .filter:
            return "filter"
        }
    }
}

// MARK: - 2. Home Router
/// Manages the low-level navigation state:
/// - `path`: A `NavigationPath` driving `NavigationStack` push/pop.
/// - `presentedSheet`: Modal sheet destination.
/// - `presentedFullScreen`: Modal full-screen cover destination.
///
/// NOTE: In SwiftUI, `NavigationStack` is a struct (View), not an open class.
/// Therefore, a Router holds observable navigation state rather than subclassing `NavigationStack`.
@MainActor
@Observable
final class HomeRouter {

    var path = NavigationPath()
    var presentedSheet: HomeRoute?
    var presentedFullScreen: HomeRoute?

    // MARK: - Push / Pop Navigation
    func push(_ route: HomeRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }

    // MARK: - Sheet Presentation
    func presentSheet(_ route: HomeRoute) {
        presentedSheet = route
    }

    func dismissSheet() {
        presentedSheet = nil
    }

    // MARK: - Full Screen Cover Presentation
    func presentFullScreen(_ route: HomeRoute) {
        presentedFullScreen = route
    }

    func dismissFullScreen() {
        presentedFullScreen = nil
    }

    // MARK: - Dismiss Any Active Modal
    func dismiss() {
        if presentedFullScreen != nil {
            presentedFullScreen = nil
        } else if presentedSheet != nil {
            presentedSheet = nil
        } else if !path.isEmpty {
            path.removeLast()
        }
    }

    func dismissAll() {
        presentedFullScreen = nil
        presentedSheet = nil
        path = NavigationPath()
    }
}

// MARK: - 3. Home Coordinator
/// The Coordinator orchestrates high-level flow transitions, acts as a View Factory,
/// and delegates cross-flow events (such as navigating to the Cart tab).
@MainActor
@Observable
final class HomeCoordinator {

    let router: HomeRouter
    var onCartTapped: (() -> Void)?

    // Shared Home flow state (e.g. for filter integration)
    var selectedCategory: String = "New Arrivals"
    var filterViewModel = FilterViewModel()

    init(onCartTapped: (() -> Void)? = nil) {
        self.router = HomeRouter()
        self.onCartTapped = onCartTapped
    }

    init(router: HomeRouter, onCartTapped: (() -> Void)? = nil) {
        self.router = router
        self.onCartTapped = onCartTapped
    }

    // MARK: - Navigation Intents (Business / Flow Logic)

    /// Navigates to product details (presented as full screen cover).
    func showProductDetails(_ product: ProductModel) {
        router.presentFullScreen(.productDetails(product))
    }

    /// Pushes the filter screen onto the navigation stack.
    func showFilter() {
        router.push(.filter)
    }

    /// Handles cart button tap, dismissing modal and triggering tab switch.
    func openCart() {
        router.dismissFullScreen()
        router.dismissSheet()
        onCartTapped?()
    }

    func pop() {
        router.pop()
    }

    func popToRoot() {
        router.popToRoot()
    }

    func dismiss() {
        router.dismiss()
    }

    // MARK: - View Factory
    @ViewBuilder
    func view(for route: HomeRoute) -> some View {
        switch route {
        case .productDetails(let product):
            ProductDetailsView(
                product: product,
                onCartTapped: { [weak self] in
                    self?.openCart()
                }
            )
        case .filter:
            FilterView(
                selectedCategory: Binding(
                    get: { self.selectedCategory },
                    set: { self.selectedCategory = $0 }
                ),
                viewModel: filterViewModel
            )
        }
    }
}

// MARK: - 4. Home Coordinator View Container
/// The SwiftUI View that hosts the `NavigationStack`, binds to `HomeRouter`,
/// and resolves views through `HomeCoordinator`.
@MainActor
struct HomeCoordinatorView: View {

    @State private var coordinator: HomeCoordinator
    @Binding var showTabBar: Bool

    init(
        coordinator: HomeCoordinator? = nil,
        showTabBar: Binding<Bool> = .constant(true),
        onCartTapped: (() -> Void)? = nil
    ) {
        self._coordinator = State(
            initialValue: coordinator ?? HomeCoordinator(onCartTapped: onCartTapped)
        )
        self._showTabBar = showTabBar
    }

    var body: some View {
        @Bindable var router = coordinator.router

        NavigationStack(path: $router.path) {
            HomeView(
                showTabBar: $showTabBar,
                coordinator: coordinator,
                onCartTapped: coordinator.onCartTapped
            )
            .navigationDestination(for: HomeRoute.self) { route in
                coordinator.view(for: route)
            }
        }
        .fullScreenCover(item: $router.presentedFullScreen) { route in
            coordinator.view(for: route)
        }
        .sheet(item: $router.presentedSheet) { route in
            coordinator.view(for: route)
        }
        .onChange(of: router.path) { _, newPath in
            // Hide custom tab bar when navigating deeper into stack
            showTabBar = newPath.isEmpty
        }
        .environment(coordinator)
        .environment(coordinator.router)
    }
}

// MARK: - Backwards-Compatibility Typealiases
typealias homeCoordinator = HomeCoordinator
typealias router = HomeRouter
