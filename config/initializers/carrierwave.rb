CarrierWave.configure do |config|

  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
      config.asset_host = ActionController::Base.asset_host
      #config.asset_host = Rails.application.complete_url
    end
  end

  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end

  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => Rails.application.secrets.amazon_s3_access_key_id,            # required
    :aws_secret_access_key  => Rails.application.secrets.amazon_s3_secret_access_key,                # required
    :region                 => 'ap-south-1'                        # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = Rails.application.secrets.amazon_s3_bucket_name                    # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>"max-age=#{1.year.to_i}"}  # optional, defaults to {}
  end

end