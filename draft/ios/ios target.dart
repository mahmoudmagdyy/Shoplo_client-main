// post_install do |installer|
// installer.pods_project.targets.each do |target|
// flutter_additional_ios_build_settings(target)
// target.build_configurations.each do |build_configuration|
// build_configuration.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64 i386'
// end
// end
// end