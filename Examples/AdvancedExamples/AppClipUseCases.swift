//
//  AppClipUseCases.swift
//  AppClipsStudio Advanced Examples
//
//  Created by AppClipsStudio on 2024.
//  Copyright © 2024 AppClipsStudio. All rights reserved.
//

import SwiftUI
import AppClipsStudio
import StoreKit
import PassKit
import MapKit

/// Advanced App Clip use cases demonstrating real-world implementations
@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, visionOS 1.0, *)
struct AppClipUseCasesView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Retail & E-commerce") {
                    NavigationLink("Quick Product Purchase") {
                        QuickPurchaseAppClipView()
                    }
                    
                    NavigationLink("In-Store Pickup") {
                        InStorePickupAppClipView()
                    }
                }
                
                Section("Food & Beverage") {
                    NavigationLink("Restaurant Ordering") {
                        RestaurantOrderingAppClipView()
                    }
                    
                    NavigationLink("Coffee Shop Loyalty") {
                        CoffeeShopAppClipView()
                    }
                }
                
                Section("Transportation") {
                    NavigationLink("Parking Payment") {
                        ParkingPaymentAppClipView()
                    }
                    
                    NavigationLink("Bike Rental") {
                        BikeRentalAppClipView()
                    }
                }
                
                Section("Entertainment") {
                    NavigationLink("Event Tickets") {
                        EventTicketingAppClipView()
                    }
                    
                    NavigationLink("Museum Guide") {
                        MuseumGuideAppClipView()
                    }
                }
                
                Section("Services") {
                    NavigationLink("Appointment Booking") {
                        AppointmentBookingAppClipView()
                    }
                    
                    NavigationLink("Package Delivery") {
                        PackageDeliveryAppClipView()
                    }
                }
            }
            .navigationTitle("App Clip Use Cases")
        }
    }
}

// MARK: - Quick Product Purchase App Clip

/// Quick product purchase flow optimized for instant conversion
@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, visionOS 1.0, *)
struct QuickPurchaseAppClipView: View {
    @StateObject private var viewModel = QuickPurchaseViewModel()
    @State private var showingPaymentSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let product = viewModel.product {
                    // Product Hero Section
                    ProductHeroView(product: product)
                    
                    // Quick Purchase Options
                    QuickPurchaseOptionsView(
                        product: product,
                        onApplePayTapped: {
                            await viewModel.initiateApplePay()
                        },
                        onBuyNowTapped: {
                            showingPaymentSheet = true
                        }
                    )
                    
                    // Trust & Security Indicators
                    TrustIndicatorsView()
                    
                    // Product Details (Minimal for quick decision)
                    ProductDetailsView(product: product)
                    
                } else if viewModel.isLoading {
                    LoadingView(message: "Loading product...")
                } else {
                    ErrorView(error: viewModel.errorMessage) {
                        await viewModel.loadProduct()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Quick Purchase")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.initialize()
        }
        .sheet(isPresented: $showingPaymentSheet) {
            PaymentSheetView(product: viewModel.product) { success in
                if success {
                    await viewModel.completePurchase()
                }
                showingPaymentSheet = false
            }
        }
    }
}

@MainActor
final class QuickPurchaseViewModel: ObservableObject {
    @Published var product: Product?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var purchaseStatus: PurchaseStatus = .idle
    
    private let core = AppClipCore.shared
    private let router = AppClipRouter.shared
    private let analytics = AppClipAnalytics.shared
    private let networking = AppClipNetworking.shared
    private let security = AppClipSecurity.shared
    
    func initialize() async {
        isLoading = true
        
        do {
            // Initialize AppClipsStudio with quick setup
            try await core.quickSetup()
            
            // Process deep link to get product ID
            guard let productId = await router.getParameter("product_id") else {
                throw AppClipError.missingProductId
            }
            
            // Track App Clip launch
            await analytics.trackEvent("app_clip_launched", properties: [
                "product_id": productId,
                "source": "qr_code",
                "use_case": "quick_purchase"
            ])
            
            // Load product data
            await loadProduct(id: productId)
            
        } catch {
            errorMessage = "Failed to load product: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func loadProduct(id: String? = nil) async {
        guard let productId = id ?? await router.getParameter("product_id") else { return }
        
        do {
            let productData = try await networking.fetchData(from: "/api/products/\(productId)")
            
            if let product = try? JSONDecoder().decode(Product.self, from: productData) {
                self.product = product
                
                // Track product view
                await analytics.trackEvent("product_viewed", properties: [
                    "product_id": product.id,
                    "product_name": product.name,
                    "price": product.price
                ])
                
                // Preload related data for faster checkout
                await preloadCheckoutData()
                
            } else {
                throw AppClipError.invalidProductData
            }
            
        } catch {
            errorMessage = "Failed to load product: \(error.localizedDescription)"
        }
    }
    
    func initiateApplePay() async {
        guard let product = product else { return }
        
        // Track Apple Pay initiation
        await analytics.trackEvent("apple_pay_initiated", properties: [
            "product_id": product.id,
            "amount": product.price
        ])
        
        // Set up Apple Pay (simplified for example)
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = "merchant.com.example.appclip"
        paymentRequest.supportedNetworks = [.visa, .masterCard, .amex]
        paymentRequest.merchantCapabilities = .threeDSecure
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        
        let item = PKPaymentSummaryItem(label: product.name, amount: NSDecimalNumber(value: product.price))
        paymentRequest.paymentSummaryItems = [item]
        
        // Present Apple Pay sheet (implementation would continue here)
        purchaseStatus = .processing
    }
    
    func completePurchase() async {
        guard let product = product else { return }
        
        purchaseStatus = .processing
        
        do {
            // Create order
            let order = try await createOrder(for: product)
            
            // Process payment
            let paymentResult = try await processPayment(for: order)
            
            if paymentResult.success {
                purchaseStatus = .completed
                
                // Track successful purchase
                await analytics.trackEvent("purchase_completed", properties: [
                    "product_id": product.id,
                    "order_id": order.id,
                    "amount": product.price,
                    "payment_method": paymentResult.method
                ])
                
                // Show success state
                await showPurchaseSuccess(order: order)
                
            } else {
                throw AppClipError.paymentFailed
            }
            
        } catch {
            purchaseStatus = .failed
            await analytics.trackEvent("purchase_failed", properties: [
                "product_id": product.id,
                "error": error.localizedDescription
            ])
        }
    }
    
    private func preloadCheckoutData() async {
        // Preload shipping options, tax calculations, etc.
        async let shippingTask = loadShippingOptions()
        async let taxTask = calculateTax()
        async let inventoryTask = checkInventory()
        
        await (shippingTask, taxTask, inventoryTask)
    }
    
    private func createOrder(for product: Product) async throws -> Order {
        let orderData = [
            "product_id": product.id,
            "quantity": 1,
            "app_clip": true
        ]
        
        let responseData = try await networking.postData(to: "/api/orders", data: orderData)
        return try JSONDecoder().decode(Order.self, from: responseData)
    }
    
    private func processPayment(for order: Order) async throws -> PaymentResult {
        // Simulate payment processing
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
        return PaymentResult(success: true, transactionId: UUID().uuidString, method: "apple_pay")
    }
    
    private func showPurchaseSuccess(order: Order) async {
        // Show order confirmation and suggest full app download
        await analytics.trackEvent("app_clip_success_shown", properties: [
            "order_id": order.id
        ])
    }
    
    private func loadShippingOptions() async {
        // Load shipping options
    }
    
    private func calculateTax() async {
        // Calculate tax
    }
    
    private func checkInventory() async {
        // Check inventory
    }
}

// MARK: - Restaurant Ordering App Clip

/// Restaurant ordering with menu browsing and quick ordering
@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, visionOS 1.0, *)
struct RestaurantOrderingAppClipView: View {
    @StateObject private var viewModel = RestaurantOrderingViewModel()
    @State private var selectedCategory: MenuCategory = .appetizers
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let restaurant = viewModel.restaurant {
                    // Restaurant Header
                    RestaurantHeaderView(restaurant: restaurant)
                    
                    // Menu Categories
                    MenuCategoriesView(
                        categories: viewModel.menuCategories,
                        selectedCategory: $selectedCategory
                    )
                    
                    // Menu Items
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.getMenuItems(for: selectedCategory), id: \.id) { item in
                            MenuItemView(item: item) {
                                await viewModel.addToOrder(item)
                            }
                        }
                    }
                    
                    // Order Summary (if items in cart)
                    if !viewModel.orderItems.isEmpty {
                        OrderSummaryView(
                            items: viewModel.orderItems,
                            total: viewModel.orderTotal
                        ) {
                            await viewModel.submitOrder()
                        }
                    }
                    
                } else if viewModel.isLoading {
                    RestaurantLoadingView()
                } else {
                    ErrorView(error: viewModel.errorMessage) {
                        await viewModel.loadRestaurantData()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Order Food")
        .task {
            await viewModel.initialize()
        }
    }
}

@MainActor
final class RestaurantOrderingViewModel: ObservableObject {
    @Published var restaurant: Restaurant?
    @Published var menuCategories: [MenuCategory] = []
    @Published var menuItems: [MenuItem] = []
    @Published var orderItems: [OrderItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var orderTotal: Double {
        orderItems.reduce(0) { $0 + ($1.item.price * Double($1.quantity)) }
    }
    
    private let core = AppClipCore.shared
    private let router = AppClipRouter.shared
    private let analytics = AppClipAnalytics.shared
    private let networking = AppClipNetworking.shared
    
    func initialize() async {
        isLoading = true
        
        do {
            // Quick App Clip setup for restaurant ordering
            try await core.initialize(with: AppClipConfiguration.restaurantOptimized)
            
            // Get restaurant ID from deep link
            guard let restaurantId = await router.getParameter("restaurant_id") else {
                throw AppClipError.missingRestaurantId
            }
            
            // Track restaurant App Clip launch
            await analytics.trackEvent("restaurant_app_clip_launched", properties: [
                "restaurant_id": restaurantId,
                "source": await router.getParameter("source") ?? "unknown"
            ])
            
            // Load restaurant data
            await loadRestaurantData(id: restaurantId)
            
        } catch {
            errorMessage = "Failed to load restaurant: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func loadRestaurantData(id: String? = nil) async {
        guard let restaurantId = id ?? await router.getParameter("restaurant_id") else { return }
        
        do {
            // Load restaurant info and menu in parallel
            async let restaurantTask = loadRestaurant(id: restaurantId)
            async let menuTask = loadMenu(for: restaurantId)
            
            await (restaurantTask, menuTask)
            
        } catch {
            errorMessage = "Failed to load restaurant data: \(error.localizedDescription)"
        }
    }
    
    private func loadRestaurant(id: String) async {
        do {
            let data = try await networking.fetchData(from: "/api/restaurants/\(id)")
            self.restaurant = try JSONDecoder().decode(Restaurant.self, from: data)
            
            await analytics.trackEvent("restaurant_loaded", properties: [
                "restaurant_id": id,
                "restaurant_name": restaurant?.name ?? "unknown"
            ])
            
        } catch {
            errorMessage = "Failed to load restaurant: \(error.localizedDescription)"
        }
    }
    
    private func loadMenu(for restaurantId: String) async {
        do {
            let data = try await networking.fetchData(from: "/api/restaurants/\(restaurantId)/menu")
            let menuResponse = try JSONDecoder().decode(MenuResponse.self, from: data)
            
            self.menuCategories = menuResponse.categories
            self.menuItems = menuResponse.items
            
            await analytics.trackEvent("menu_loaded", properties: [
                "restaurant_id": restaurantId,
                "categories_count": menuCategories.count,
                "items_count": menuItems.count
            ])
            
        } catch {
            errorMessage = "Failed to load menu: \(error.localizedDescription)"
        }
    }
    
    func getMenuItems(for category: MenuCategory) -> [MenuItem] {
        return menuItems.filter { $0.category == category }
    }
    
    func addToOrder(_ item: MenuItem) async {
        if let existingIndex = orderItems.firstIndex(where: { $0.item.id == item.id }) {
            orderItems[existingIndex].quantity += 1
        } else {
            orderItems.append(OrderItem(item: item, quantity: 1))
        }
        
        await analytics.trackEvent("item_added_to_order", properties: [
            "item_id": item.id,
            "item_name": item.name,
            "price": item.price,
            "order_total": orderTotal
        ])
    }
    
    func submitOrder() async {
        guard !orderItems.isEmpty else { return }
        
        do {
            let orderRequest = OrderRequest(
                restaurantId: restaurant?.id ?? "",
                items: orderItems.map { OrderRequestItem(itemId: $0.item.id, quantity: $0.quantity) },
                total: orderTotal
            )
            
            let orderData = try JSONEncoder().encode(orderRequest)
            let responseData = try await networking.postData(to: "/api/orders", data: orderData)
            let order = try JSONDecoder().decode(Order.self, from: responseData)
            
            // Track successful order
            await analytics.trackEvent("order_submitted", properties: [
                "order_id": order.id,
                "restaurant_id": restaurant?.id ?? "",
                "total_amount": orderTotal,
                "items_count": orderItems.count
            ])
            
            // Clear order
            orderItems.removeAll()
            
            // Show success and suggest full app download
            await showOrderSuccess(order: order)
            
        } catch {
            await analytics.trackEvent("order_failed", properties: [
                "error": error.localizedDescription,
                "total_amount": orderTotal
            ])
        }
    }
    
    private func showOrderSuccess(order: Order) async {
        // Show order confirmation with estimated time
        await analytics.trackEvent("order_success_shown", properties: [
            "order_id": order.id,
            "estimated_time": order.estimatedTime
        ])
    }
}

// MARK: - Parking Payment App Clip

/// Instant parking payment with location-based setup
@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, visionOS 1.0, *)
struct ParkingPaymentAppClipView: View {
    @StateObject private var viewModel = ParkingPaymentViewModel()
    @State private var selectedDuration: ParkingDuration = .oneHour
    
    var body: some View {
        VStack(spacing: 24) {
            if let parkingSpot = viewModel.parkingSpot {
                // Parking Spot Info
                ParkingSpotHeaderView(spot: parkingSpot)
                
                // Duration Selection
                ParkingDurationSelectorView(
                    durations: viewModel.availableDurations,
                    selected: $selectedDuration,
                    rates: viewModel.parkingRates
                )
                
                // License Plate Input
                LicensePlateInputView(
                    licensePlate: $viewModel.licensePlate,
                    isValid: viewModel.isLicensePlateValid
                )
                
                // Payment Summary
                PaymentSummaryView(
                    duration: selectedDuration,
                    rate: viewModel.getRateFor(selectedDuration),
                    total: viewModel.calculateTotal(for: selectedDuration)
                )
                
                Spacer()
                
                // Payment Button
                PaymentButtonView(
                    isEnabled: viewModel.canMakePayment,
                    isProcessing: viewModel.isProcessingPayment
                ) {
                    await viewModel.makePayment(duration: selectedDuration)
                }
                
            } else if viewModel.isLoading {
                ParkingLoadingView()
            } else {
                ErrorView(error: viewModel.errorMessage) {
                    await viewModel.loadParkingSpot()
                }
            }
        }
        .padding()
        .navigationTitle("Pay for Parking")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.initialize()
        }
    }
}

@MainActor
final class ParkingPaymentViewModel: ObservableObject {
    @Published var parkingSpot: ParkingSpot?
    @Published var availableDurations: [ParkingDuration] = []
    @Published var parkingRates: [ParkingDuration: Double] = [:]
    @Published var licensePlate = ""
    @Published var isProcessingPayment = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var isLicensePlateValid: Bool {
        licensePlate.count >= 3 && licensePlate.allSatisfy { $0.isLetter || $0.isNumber }
    }
    
    var canMakePayment: Bool {
        !isProcessingPayment && isLicensePlateValid && parkingSpot != nil
    }
    
    private let core = AppClipCore.shared
    private let router = AppClipRouter.shared
    private let analytics = AppClipAnalytics.shared
    private let networking = AppClipNetworking.shared
    private let storage = AppClipStorage.shared
    
    func initialize() async {
        isLoading = true
        
        do {
            // Quick setup for parking payment
            try await core.initialize(with: AppClipConfiguration.parkingOptimized)
            
            // Get parking spot ID from QR code/NFC
            guard let spotId = await router.getParameter("spot_id") else {
                throw AppClipError.missingSpotId
            }
            
            // Load saved license plate if available
            if let savedPlate = await storage.getString(key: "license_plate") {
                licensePlate = savedPlate
            }
            
            // Track parking App Clip launch
            await analytics.trackEvent("parking_app_clip_launched", properties: [
                "spot_id": spotId,
                "has_saved_plate": !licensePlate.isEmpty
            ])
            
            // Load parking spot data
            await loadParkingSpot(id: spotId)
            
        } catch {
            errorMessage = "Failed to load parking spot: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func loadParkingSpot(id: String? = nil) async {
        guard let spotId = id ?? await router.getParameter("spot_id") else { return }
        
        do {
            let data = try await networking.fetchData(from: "/api/parking/spots/\(spotId)")
            let spotResponse = try JSONDecoder().decode(ParkingSpotResponse.self, from: data)
            
            self.parkingSpot = spotResponse.spot
            self.availableDurations = spotResponse.availableDurations
            self.parkingRates = spotResponse.rates
            
            await analytics.trackEvent("parking_spot_loaded", properties: [
                "spot_id": spotId,
                "location": spotResponse.spot.location,
                "available_durations": availableDurations.count
            ])
            
        } catch {
            errorMessage = "Failed to load parking spot: \(error.localizedDescription)"
        }
    }
    
    func getRateFor(_ duration: ParkingDuration) -> Double {
        return parkingRates[duration] ?? 0.0
    }
    
    func calculateTotal(for duration: ParkingDuration) -> Double {
        let rate = getRateFor(duration)
        let tax = rate * 0.1 // 10% tax
        return rate + tax
    }
    
    func makePayment(duration: ParkingDuration) async {
        guard let spot = parkingSpot, canMakePayment else { return }
        
        isProcessingPayment = true
        
        do {
            // Save license plate for future use
            await storage.store(key: "license_plate", value: licensePlate)
            
            // Create parking session
            let paymentRequest = ParkingPaymentRequest(
                spotId: spot.id,
                licensePlate: licensePlate,
                duration: duration,
                amount: calculateTotal(for: duration)
            )
            
            let paymentData = try JSONEncoder().encode(paymentRequest)
            let responseData = try await networking.postData(to: "/api/parking/payment", data: paymentData)
            let session = try JSONDecoder().decode(ParkingSession.self, from: responseData)
            
            // Track successful payment
            await analytics.trackEvent("parking_payment_completed", properties: [
                "session_id": session.id,
                "spot_id": spot.id,
                "duration": duration.rawValue,
                "amount": session.amount
            ])
            
            // Show payment success
            await showPaymentSuccess(session: session)
            
        } catch {
            await analytics.trackEvent("parking_payment_failed", properties: [
                "spot_id": spot.id,
                "error": error.localizedDescription
            ])
            
            errorMessage = "Payment failed: \(error.localizedDescription)"
        }
        
        isProcessingPayment = false
    }
    
    private func showPaymentSuccess(session: ParkingSession) async {
        // Show payment confirmation with session details
        await analytics.trackEvent("parking_success_shown", properties: [
            "session_id": session.id,
            "expires_at": ISO8601DateFormatter().string(from: session.expiresAt)
        ])
    }
}

// MARK: - Event Ticketing App Clip

/// Event ticket purchase with seat selection and instant delivery
@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, visionOS 1.0, *)
struct EventTicketingAppClipView: View {
    @StateObject private var viewModel = EventTicketingViewModel()
    @State private var selectedSeats: Set<Seat> = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let event = viewModel.event {
                    // Event Header
                    EventHeaderView(event: event)
                    
                    // Seat Map
                    SeatMapView(
                        venue: event.venue,
                        availableSeats: viewModel.availableSeats,
                        selectedSeats: $selectedSeats,
                        maxSeats: 4
                    )
                    
                    // Ticket Summary
                    if !selectedSeats.isEmpty {
                        TicketSummaryView(
                            seats: Array(selectedSeats),
                            event: event,
                            total: viewModel.calculateTotal(for: selectedSeats)
                        )
                    }
                    
                    // Purchase Button
                    if !selectedSeats.isEmpty {
                        PurchaseTicketsButtonView(
                            isEnabled: !viewModel.isProcessing,
                            seatCount: selectedSeats.count
                        ) {
                            await viewModel.purchaseTickets(seats: selectedSeats)
                        }
                    }
                    
                } else if viewModel.isLoading {
                    EventLoadingView()
                } else {
                    ErrorView(error: viewModel.errorMessage) {
                        await viewModel.loadEvent()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Buy Tickets")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.initialize()
        }
    }
}

@MainActor
final class EventTicketingViewModel: ObservableObject {
    @Published var event: Event?
    @Published var availableSeats: [Seat] = []
    @Published var isProcessing = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let core = AppClipCore.shared
    private let router = AppClipRouter.shared
    private let analytics = AppClipAnalytics.shared
    private let networking = AppClipNetworking.shared
    
    func initialize() async {
        isLoading = true
        
        do {
            // Initialize for event ticketing
            try await core.initialize(with: AppClipConfiguration.eventOptimized)
            
            // Get event ID from deep link
            guard let eventId = await router.getParameter("event_id") else {
                throw AppClipError.missingEventId
            }
            
            // Track event App Clip launch
            await analytics.trackEvent("event_app_clip_launched", properties: [
                "event_id": eventId
            ])
            
            // Load event data
            await loadEvent(id: eventId)
            
        } catch {
            errorMessage = "Failed to load event: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func loadEvent(id: String? = nil) async {
        guard let eventId = id ?? await router.getParameter("event_id") else { return }
        
        do {
            // Load event info and available seats in parallel
            async let eventTask = loadEventInfo(id: eventId)
            async let seatsTask = loadAvailableSeats(for: eventId)
            
            await (eventTask, seatsTask)
            
        } catch {
            errorMessage = "Failed to load event data: \(error.localizedDescription)"
        }
    }
    
    private func loadEventInfo(id: String) async {
        do {
            let data = try await networking.fetchData(from: "/api/events/\(id)")
            self.event = try JSONDecoder().decode(Event.self, from: data)
            
            await analytics.trackEvent("event_loaded", properties: [
                "event_id": id,
                "event_name": event?.name ?? "unknown",
                "event_date": ISO8601DateFormatter().string(from: event?.date ?? Date())
            ])
            
        } catch {
            errorMessage = "Failed to load event: \(error.localizedDescription)"
        }
    }
    
    private func loadAvailableSeats(for eventId: String) async {
        do {
            let data = try await networking.fetchData(from: "/api/events/\(eventId)/seats")
            self.availableSeats = try JSONDecoder().decode([Seat].self, from: data)
            
            await analytics.trackEvent("seats_loaded", properties: [
                "event_id": eventId,
                "available_seats": availableSeats.count
            ])
            
        } catch {
            errorMessage = "Failed to load seats: \(error.localizedDescription)"
        }
    }
    
    func calculateTotal(for seats: Set<Seat>) -> Double {
        let subtotal = seats.reduce(0) { $0 + $1.price }
        let fees = subtotal * 0.15 // 15% service fees
        return subtotal + fees
    }
    
    func purchaseTickets(seats: Set<Seat>) async {
        guard let event = event, !seats.isEmpty else { return }
        
        isProcessing = true
        
        do {
            let ticketRequest = TicketPurchaseRequest(
                eventId: event.id,
                seatIds: seats.map { $0.id },
                total: calculateTotal(for: seats)
            )
            
            let requestData = try JSONEncoder().encode(ticketRequest)
            let responseData = try await networking.postData(to: "/api/tickets/purchase", data: requestData)
            let tickets = try JSONDecoder().decode([Ticket].self, from: responseData)
            
            // Track successful purchase
            await analytics.trackEvent("tickets_purchased", properties: [
                "event_id": event.id,
                "ticket_count": tickets.count,
                "total_amount": calculateTotal(for: seats),
                "seat_ids": seats.map { $0.id }
            ])
            
            // Show purchase success with digital tickets
            await showTicketsSuccess(tickets: tickets)
            
        } catch {
            await analytics.trackEvent("ticket_purchase_failed", properties: [
                "event_id": event.id,
                "error": error.localizedDescription
            ])
            
            errorMessage = "Ticket purchase failed: \(error.localizedDescription)"
        }
        
        isProcessing = false
    }
    
    private func showTicketsSuccess(tickets: [Ticket]) async {
        // Show digital tickets and suggest adding to Wallet
        await analytics.trackEvent("tickets_success_shown", properties: [
            "ticket_count": tickets.count,
            "event_id": event?.id ?? ""
        ])
    }
}

// MARK: - Supporting Views

struct ProductHeroView: View {
    let product: Product
    
    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: product.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .aspectRatio(1, contentMode: .fit)
            }
            .frame(height: 200)
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
        }
    }
}

struct LoadingView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.2)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ErrorView: View {
    let error: String?
    let retry: () async -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.orange)
            
            Text(error ?? "Something went wrong")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Button("Try Again") {
                Task {
                    await retry()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Data Models

struct Product: Codable, Identifiable {
    let id: String
    let name: String
    let price: Double
    let imageUrl: String
    let description: String
}

struct Restaurant: Codable, Identifiable {
    let id: String
    let name: String
    let cuisine: String
    let rating: Double
    let imageUrl: String
    let estimatedDeliveryTime: Int
}

struct MenuItem: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let category: MenuCategory
    let imageUrl: String?
    let isAvailable: Bool
}

enum MenuCategory: String, CaseIterable, Codable {
    case appetizers = "appetizers"
    case mains = "mains"
    case desserts = "desserts"
    case drinks = "drinks"
    
    var displayName: String {
        switch self {
        case .appetizers: return "Appetizers"
        case .mains: return "Main Courses"
        case .desserts: return "Desserts"
        case .drinks: return "Drinks"
        }
    }
}

struct OrderItem: Identifiable {
    let id = UUID()
    let item: MenuItem
    var quantity: Int
}

struct ParkingSpot: Codable, Identifiable {
    let id: String
    let location: String
    let address: String
    let coordinates: Coordinates
    let maxDuration: ParkingDuration
}

enum ParkingDuration: String, CaseIterable, Codable {
    case thirtyMinutes = "30min"
    case oneHour = "1h"
    case twoHours = "2h"
    case fourHours = "4h"
    case allDay = "all_day"
    
    var displayName: String {
        switch self {
        case .thirtyMinutes: return "30 minutes"
        case .oneHour: return "1 hour"
        case .twoHours: return "2 hours"
        case .fourHours: return "4 hours"
        case .allDay: return "All day"
        }
    }
}

struct Event: Codable, Identifiable {
    let id: String
    let name: String
    let date: Date
    let venue: Venue
    let description: String
    let imageUrl: String
}

struct Venue: Codable {
    let name: String
    let address: String
    let seatMap: SeatMap
}

struct Seat: Codable, Identifiable, Hashable {
    let id: String
    let section: String
    let row: String
    let number: String
    let price: Double
    let isAvailable: Bool
}

// Additional supporting types...
enum AppClipError: LocalizedError {
    case missingProductId
    case missingRestaurantId
    case missingSpotId
    case missingEventId
    case invalidProductData
    case paymentFailed
    
    var errorDescription: String? {
        switch self {
        case .missingProductId: return "Product ID not found"
        case .missingRestaurantId: return "Restaurant ID not found"
        case .missingSpotId: return "Parking spot ID not found"
        case .missingEventId: return "Event ID not found"
        case .invalidProductData: return "Invalid product data"
        case .paymentFailed: return "Payment processing failed"
        }
    }
}

// Configuration extensions for different use cases
extension AppClipConfiguration {
    static let restaurantOptimized = AppClipConfiguration(
        maxMemoryUsage: 8 * 1024 * 1024,
        cachePolicy: .aggressive,
        analyticsEnabled: true,
        securityLevel: .standard,
        performanceMode: .optimized
    )
    
    static let parkingOptimized = AppClipConfiguration(
        maxMemoryUsage: 6 * 1024 * 1024,
        cachePolicy: .minimal,
        analyticsEnabled: true,
        securityLevel: .enhanced,
        performanceMode: .battery
    )
    
    static let eventOptimized = AppClipConfiguration(
        maxMemoryUsage: 10 * 1024 * 1024,
        cachePolicy: .balanced,
        analyticsEnabled: true,
        securityLevel: .standard,
        performanceMode: .balanced
    )
}

#Preview {
    AppClipUseCasesView()
}