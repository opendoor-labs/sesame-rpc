# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/protobuf/struct.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.protobuf.Struct" do
    map :fields, :string, :message, 1, "google.protobuf.Value"
  end
  add_message "google.protobuf.Value" do
    oneof :kind do
      optional :null_value, :enum, 1, "google.protobuf.NullValue"
      optional :number_value, :double, 2
      optional :string_value, :string, 3
      optional :bool_value, :bool, 4
      optional :struct_value, :message, 5, "google.protobuf.Struct"
      optional :list_value, :message, 6, "google.protobuf.ListValue"
    end
  end
  add_message "google.protobuf.ListValue" do
    repeated :values, :message, 1, "google.protobuf.Value"
  end
  add_enum "google.protobuf.NullValue" do
    value :NULL_VALUE, 0
  end
end

module Google
  module Protobuf
    Struct = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.protobuf.Struct").msgclass
    Value = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.protobuf.Value").msgclass
    ListValue = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.protobuf.ListValue").msgclass
    NullValue = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.protobuf.NullValue").enummodule
  end
end
