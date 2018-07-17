PROJECT = 'CointrackingBar'

def deployment_target(target, key)
  project = Xcodeproj::Project.open("#{PROJECT}.xcodeproj")
  target = project.targets.select { |x| x.name == target }[0]
  return target.common_resolved_build_setting(key)
end

platform :osx, deployment_target(PROJECT, 'MACOSX_DEPLOYMENT_TARGET')

target 'CointrackingBar' do  
  pod 'Fabric'
  pod 'Crashlytics'
end

post_install do |installer|
    installer.pods_project.build_configuration_list.build_configurations.each do |c|
        c.build_settings["DEBUG_INFORMATION_FORMAT"] = "dwarf-with-dsym"
    end
end

use_frameworks!
inhibit_all_warnings!
