# encoding: utf-8
module ApplicationHelper
  MAPPING = JSON.parse(File.open(Rails.root.join('assets.json')).read)

  def assets_path(asset_name)
    if Rails.env.production?
      "/dist/#{MAPPING[asset_name]}"
    else
      "/dist/#{asset_name}"
    end
  end
end
