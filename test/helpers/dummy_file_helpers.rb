# frozen_string_literal: true

module DummyFileHelpers
  def dummy_file
    { io: File.open(Rails.root.join('public', 'apple-touch-icon.png')), filename: 'dummy_file.png',
      content_type: 'image/png' }
  end

  def big_file
    { io: File.open(Rails.root.join('public', '500.html')), filename: 'big_file.png', content_type: 'image/png' }
  end

  def pdf_file
    { io: File.open(Rails.root.join('public', 'pdf.pdf')), filename: 'pdf_file.pdf', content_type: 'application/pdf' }
  end

  def bad_dummy_file
    { io: File.open(Rails.root.join('public', 'apple-touch-icon.png')), filename: 'bad_dummy_file.png',
      content_type: 'text/plain' }
  end

  def image_150x150_file
    { io: File.open(Rails.root.join('public', 'image_150x150.png')), filename: 'image_150x150_file.png',
      content_type: 'image/png' }
  end

  def image_800x600_file
    { io: File.open(Rails.root.join('public', 'image_800x600.png')), filename: 'image_800x600_file.png',
      content_type: 'image/png' }
  end

  def image_600x800_file
    { io: File.open(Rails.root.join('public', 'image_600x800.png')), filename: 'image_600x800_file.png',
      content_type: 'image/png' }
  end

  def image_1200x900_file
    { io: File.open(Rails.root.join('public', 'image_1200x900.png')), filename: 'image_1200x900_file.png',
      content_type: 'image/png' }
  end

  def image_1920x1080_file
    { io: File.open(Rails.root.join('public', 'image_1920x1080.png')), filename: 'image_1920x1080_file.png',
      content_type: 'image/png' }
  end

  def html_file
    { io: File.open(Rails.root.join('public', '500.html')), filename: 'html_file.html', content_type: 'text/html' }
  end

  def webp_file
    { io: File.open(Rails.root.join('public', '1_sm_webp.png')), filename: '1_sm_webp.png', content_type: 'image/webp' }
  end

  def webp_file_wrong
    { io: File.open(Rails.root.join('public', '1_sm_webp.png')), filename: '1_sm_webp.png', content_type: 'image/png' }
  end
end
