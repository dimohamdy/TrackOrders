# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'
def rxswift_pods
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
end

def realm_pods
    pod 'RealmSwift'
end

target 'TrackOrders' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for GallaryApp
  pod 'ALCameraViewController'
  rxswift_pods
  pod 'NVActivityIndicatorView'
  pod 'AlamofireImage'
  pod 'SimpleImageViewer', '~> 1.1.1'
  pod 'SwiftMessages'
  pod 'AlamofireNetworkActivityIndicator'
  pod 'SnapKit', '~> 4.0.0'
  realm_pods
end

target 'TrackOrdersTests' do
  inherit! :search_paths
  use_frameworks!
  # Pods for testing
  pod 'Quick'
  pod 'Nimble'
  realm_pods
end
