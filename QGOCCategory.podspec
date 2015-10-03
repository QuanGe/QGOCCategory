Pod::Spec.new do |s|
  s.name     = 'QGOCCategory'
  s.version  = '0.1.1'
  s.platform = :ios, '7.0'
  s.license  = 'MIT'
  s.summary  = 'get some iOS Object-C category '
  s.homepage = 'https://github.com/QuanGe/QGOCCategory'
  s.author   = { 'QuanGe' => 'zhang_ru_quan@163.com' }
  s.source   = { :git => 'https://github.com/QuanGe/QGOCCategory.git', :tag => s.version.to_s }

  s.description = 'get some iOS Object-C category' 

  s.frameworks   = 'QuartzCore'
  s.source_files = 'QGOCCategory/*.{h,m}'
  s.preserve_paths  = 'Demo'
  s.requires_arc = true
end
