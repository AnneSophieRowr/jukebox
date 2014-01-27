class KindDecorator < Draper::Decorator
  delegate_all

  def visible
    object.visible ? I18n.t('helpers.words.yeslabel') : I18n.t('helpers.words.nolabel')
  end

end
