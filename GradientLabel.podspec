Pod::Spec.new do |spec|
  spec.name         = "GradientLabel"      #名称
  spec.version      = "1.0.0"              #版本号
  spec.summary      = "为UILabe添加颜色渐变效果的Category"
  spec.homepage     = "http://findertiwk.github.io"
  spec.license      = 'MIT'
  spec.author       = { "_Finder丶Tiwk" => "136652711@qq.com" }
  spec.source       = { :git => "https://github.com/FinderTiwk/GradientLabel.git", :tag => "v1.0.0" }
  spec.platform     = :ios, '8.0'    #支持的系统
  spec.requires_arc = true           #是否需要arc
  spec.source_files = 'GradientLabel/UILabel+Gradient.{h,m}'
  spec.public_header_files = 'GradientLabel/UILabel+Gradient.h'

end
