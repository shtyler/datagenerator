
require 'liquid'
require 'json'


template_path = './datagen/templates/1_generate_os.liquid'

ldm_path = './datagen/param_definitions/LDM.json'

template = Liquid::Template.parse(File.read(template_path))	

puts template.render(JSON.parse(File.read(ldm_path)))
