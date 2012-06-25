# -*- encoding : utf-8 -*-
#encoding: UTF-8

class Document < ActiveRecord::Base
  
  belongs_to :transaction
  mount_uploader :doc, DocumentUploader
  
  def detect_format
    @format = doc.file.extension.upcase
    case @format
    when "DOC", "DOCX", "DOT", "DOTX"
      ("app/file_doc.png")
    when "JPG", "JPEG", "GIF"
      ("app/file_jpg.png")
    when "PNG"
      ("app/file_png.png")
    when "BMP"
      ("app/file_bmp.png")
    when "PPT", "PPTX"
      ("app/file_ppt.png")
    when "RTF"
      ("app/file_rtf.png")
    when "TXT"
      ("app/file_txt.png")
    when "XLSX", "XLS", "XLTX", "XLT", "CSV"
      ("app/file_xls.png")
    when "XML", "HTM", "HTML"
      ("app/file_html.png")
    when "PDF"
      ("app/file_pdf.png")
    end
  end
  
end
# == Schema Information
#
# Table name: documents
#
#  id             :integer(4)      not null, primary key
#  transaction_id :integer(4)
#  doc            :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

