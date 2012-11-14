class Attachment < ActiveRecord::Base
  belongs_to :email
  attr_accessible :file, :atype
  has_attached_file :file, :path => ":rails_root/private/attachments/:id_partition/:filename"

  validates :email_id, :presence => true
  validates :file, :presence => true
  validates :atype, :inclusion => { :in => ['inline','attached','offline']}

  scope :inline, where(:atype => 'inline')
  scope :attached, where(:atype => 'attached')

  def div
    if new_record?
      return "attacnment_new"
    else
      return "attachment_" + self.to_param
    end
  end

  def atype_img
    return case atype
      when 'attached' then '16/attachment-attached.png'
      when 'inline' then '16/attachment-inline.png'
      when 'offline' then '16/attachment-offline.png'
      else '16/attachment-error.png'
    end
  end
end
