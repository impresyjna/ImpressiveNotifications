Pod::Spec.new do |spec|
  spec.name         = "ImpressiveNotifications"
  spec.version      = "0.5.0"
  spec.summary      = " ImpressiveNotifications are custom in-app notifications with 3 types of layouts."

  spec.description  = <<-DESC
  ImpressiveNotifications are custom in-app notifications with 3 types of layouts. The notifications will animate in and out. They will hide when they are clicked on or with an automatic dismissal. It is also available to add custom behavior when notification is tapped.
                   DESC

  spec.homepage     = "https://github.com/impresyjna/ImpressiveNotifications/blob/master/Resources/Banner.jpg"
  spec.license      = "GPL-3.0"
  spec.author             = { "Asia Kasprzycka" => "impresyjna@gmail.com" }
  spec.platform     = :ios, "11.0"
  spec.swift_version = "4.2"
  spec.source       = { :git => "https://github.com/impresyjna/ImpressiveNotifications.git", :tag => "#{spec.version}" }

  spec.source_files  = "ImpressiveNotifications/Sources/**/*.swift"
end
