AWS.config(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])

S3_DEV_PROTOCOL = ENV['S3_DEV_PROTOCOL']
S3_DEV_HOST = ENV['S3_DEV_HOST']
S3_DEV_PORT = ENV['S3_DEV_PORT']

if S3_DEV_HOST
  AWS.config(s3_endpoint: S3_DEV_HOST, s3_port: S3_DEV_PORT.to_i)
  if S3_DEV_PROTOCOL == 'http'
    AWS.config(use_ssl: false)
  end
end

S3_BUCKET = AWS::S3.new.buckets[ENV['S3_BUCKET']]
