#!/usr/bin/ruby

require 'minitest/autorun'

require_relative 'application_test'

require_relative 'project_test'
require_relative 'lang/lang_test'
require_relative 'lang/lang_factory_test'

require_relative 'concept/concept_test'
require_relative 'concept/table_test'
require_relative 'ai/question_test'
require_relative 'ai/concept_ai_test'

require_relative 'formatter/table_haml_formatter_test'
require_relative 'formatter/concept_haml_formatter_test'
