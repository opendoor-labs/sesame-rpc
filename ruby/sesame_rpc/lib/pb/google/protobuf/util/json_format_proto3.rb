# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/protobuf/util/json_format_proto3.proto

require 'google/protobuf'

require 'google/protobuf/duration'
require 'google/protobuf/timestamp'
require 'google/protobuf/wrappers'
require 'google/protobuf/struct'
require 'google/protobuf/any'
require 'google/protobuf/field_mask'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "proto3.MessageType" do
    optional :value, :int32, 1
  end
  add_message "proto3.TestMessage" do
    optional :bool_value, :bool, 1
    optional :int32_value, :int32, 2
    optional :int64_value, :int64, 3
    optional :uint32_value, :uint32, 4
    optional :uint64_value, :uint64, 5
    optional :float_value, :float, 6
    optional :double_value, :double, 7
    optional :string_value, :string, 8
    optional :bytes_value, :bytes, 9
    optional :enum_value, :enum, 10, "proto3.EnumType"
    optional :message_value, :message, 11, "proto3.MessageType"
    repeated :repeated_bool_value, :bool, 21
    repeated :repeated_int32_value, :int32, 22
    repeated :repeated_int64_value, :int64, 23
    repeated :repeated_uint32_value, :uint32, 24
    repeated :repeated_uint64_value, :uint64, 25
    repeated :repeated_float_value, :float, 26
    repeated :repeated_double_value, :double, 27
    repeated :repeated_string_value, :string, 28
    repeated :repeated_bytes_value, :bytes, 29
    repeated :repeated_enum_value, :enum, 30, "proto3.EnumType"
    repeated :repeated_message_value, :message, 31, "proto3.MessageType"
  end
  add_message "proto3.TestOneof" do
    oneof :oneof_value do
      optional :oneof_int32_value, :int32, 1
      optional :oneof_string_value, :string, 2
      optional :oneof_bytes_value, :bytes, 3
      optional :oneof_enum_value, :enum, 4, "proto3.EnumType"
      optional :oneof_message_value, :message, 5, "proto3.MessageType"
    end
  end
  add_message "proto3.TestMap" do
    map :bool_map, :bool, :int32, 1
    map :int32_map, :int32, :int32, 2
    map :int64_map, :int64, :int32, 3
    map :uint32_map, :uint32, :int32, 4
    map :uint64_map, :uint64, :int32, 5
    map :string_map, :string, :int32, 6
  end
  add_message "proto3.TestNestedMap" do
    map :bool_map, :bool, :int32, 1
    map :int32_map, :int32, :int32, 2
    map :int64_map, :int64, :int32, 3
    map :uint32_map, :uint32, :int32, 4
    map :uint64_map, :uint64, :int32, 5
    map :string_map, :string, :int32, 6
    map :map_map, :string, :message, 7, "proto3.TestNestedMap"
  end
  add_message "proto3.TestWrapper" do
    optional :bool_value, :message, 1, "google.protobuf.BoolValue"
    optional :int32_value, :message, 2, "google.protobuf.Int32Value"
    optional :int64_value, :message, 3, "google.protobuf.Int64Value"
    optional :uint32_value, :message, 4, "google.protobuf.UInt32Value"
    optional :uint64_value, :message, 5, "google.protobuf.UInt64Value"
    optional :float_value, :message, 6, "google.protobuf.FloatValue"
    optional :double_value, :message, 7, "google.protobuf.DoubleValue"
    optional :string_value, :message, 8, "google.protobuf.StringValue"
    optional :bytes_value, :message, 9, "google.protobuf.BytesValue"
    repeated :repeated_bool_value, :message, 11, "google.protobuf.BoolValue"
    repeated :repeated_int32_value, :message, 12, "google.protobuf.Int32Value"
    repeated :repeated_int64_value, :message, 13, "google.protobuf.Int64Value"
    repeated :repeated_uint32_value, :message, 14, "google.protobuf.UInt32Value"
    repeated :repeated_uint64_value, :message, 15, "google.protobuf.UInt64Value"
    repeated :repeated_float_value, :message, 16, "google.protobuf.FloatValue"
    repeated :repeated_double_value, :message, 17, "google.protobuf.DoubleValue"
    repeated :repeated_string_value, :message, 18, "google.protobuf.StringValue"
    repeated :repeated_bytes_value, :message, 19, "google.protobuf.BytesValue"
  end
  add_message "proto3.TestTimestamp" do
    optional :value, :message, 1, "google.protobuf.Timestamp"
    repeated :repeated_value, :message, 2, "google.protobuf.Timestamp"
  end
  add_message "proto3.TestDuration" do
    optional :value, :message, 1, "google.protobuf.Duration"
    repeated :repeated_value, :message, 2, "google.protobuf.Duration"
  end
  add_message "proto3.TestFieldMask" do
    optional :value, :message, 1, "google.protobuf.FieldMask"
  end
  add_message "proto3.TestStruct" do
    optional :value, :message, 1, "google.protobuf.Struct"
    repeated :repeated_value, :message, 2, "google.protobuf.Struct"
  end
  add_message "proto3.TestAny" do
    optional :value, :message, 1, "google.protobuf.Any"
    repeated :repeated_value, :message, 2, "google.protobuf.Any"
  end
  add_message "proto3.TestValue" do
    optional :value, :message, 1, "google.protobuf.Value"
    repeated :repeated_value, :message, 2, "google.protobuf.Value"
  end
  add_message "proto3.TestListValue" do
    optional :value, :message, 1, "google.protobuf.ListValue"
    repeated :repeated_value, :message, 2, "google.protobuf.ListValue"
  end
  add_message "proto3.TestBoolValue" do
    optional :bool_value, :bool, 1
    map :bool_map, :bool, :int32, 2
  end
  add_message "proto3.TestCustomJsonName" do
    optional :value, :int32, 1
  end
  add_enum "proto3.EnumType" do
    value :FOO, 0
    value :BAR, 1
  end
end

module Proto3
  MessageType = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.MessageType").msgclass
  TestMessage = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestMessage").msgclass
  TestOneof = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestOneof").msgclass
  TestMap = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestMap").msgclass
  TestNestedMap = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestNestedMap").msgclass
  TestWrapper = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestWrapper").msgclass
  TestTimestamp = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestTimestamp").msgclass
  TestDuration = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestDuration").msgclass
  TestFieldMask = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestFieldMask").msgclass
  TestStruct = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestStruct").msgclass
  TestAny = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestAny").msgclass
  TestValue = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestValue").msgclass
  TestListValue = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestListValue").msgclass
  TestBoolValue = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestBoolValue").msgclass
  TestCustomJsonName = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.TestCustomJsonName").msgclass
  EnumType = Google::Protobuf::DescriptorPool.generated_pool.lookup("proto3.EnumType").enummodule
end
