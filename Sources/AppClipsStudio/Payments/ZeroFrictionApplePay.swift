#if os(iOS)
import Foundation
import PassKit

/// Zero-friction Apple Pay wrapper tailored for instant App Clip checkouts.
@MainActor
public final class ZeroFrictionApplePay: NSObject, PKPaymentAuthorizationControllerDelegate, Sendable {
    private var completion: ((Bool) -> Void)?
    
    public func checkout(amount: Double, merchantIdentifier: String, completion: @escaping (Bool) -> Void) {
        self.completion = completion
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = merchantIdentifier
        request.supportedNetworks = [.visa, .masterCard, .amex]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "App Clip Purchase", amount: NSDecimalNumber(value: amount))
        ]
        
        guard let controller = PKPaymentAuthorizationController(paymentRequest: request) else {
            completion(false)
            return
        }
        
        controller.delegate = self
        controller.present { success in
            if !success { completion(false) }
        }
    }
    
    nonisolated public func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss { }
        Task { @MainActor in
            self.completion?(true)
        }
    }
    
    nonisolated public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Mock authorization
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}
#endif
