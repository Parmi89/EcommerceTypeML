module Authorization
  extend ActiveSupport::Concern

  included do
    class NotAtuthorizeError < StandardError; end

    rescue_from NotAtuthorizeError do
      redirect_to products_path, alert: t('common.not_authorized')
    end

    private

    def authorize! record = nil
      is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)   
      raise NotAtuthorizeError unless is_allowed
    end

  end
end  