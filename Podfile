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

use_frameworks!
inhibit_all_warnings!