class Orders::GenerateNumberService
  NUMBER_PREFIX = '#R'.freeze
  DATE_FORMAT = '%Y%m%d%H%M%S'.freeze

  def call
    NUMBER_PREFIX + Time.now.strftime(DATE_FORMAT)
  end
end
