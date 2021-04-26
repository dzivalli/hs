RSpec.describe Highspot::CLI do
  describe '.run' do
    subject { described_class.new.run }

    it 'prints usage if no arguments passed' do
      expect { subject }.to output("Usage: -s source file -c file with changes\nProgram failed\n").to_stdout
    end

    it 'prints usage if no required arguments' do
      ARGV = %w[-s file].freeze
      expect { subject }.to output("Usage: -s source file -c file with changes\nProgram failed\n").to_stdout
    end

    it 'prints error message if source file does not exist' do
      ARGV = %w[-s file1 -c file2].freeze
      expect { subject }.to output("JSON file invalid, path: file1\nProgram failed\n").to_stdout
    end

    it 'prints error message if file with changes does not exist' do
      ARGV = %W[-s #{"#{Dir.pwd}/spec/fixtures/source.json"} -c file2].freeze
      expect { subject }.to output("JSON file invalid, path: file2\nProgram failed\n").to_stdout
    end

    context 'when arguments are valid' do
      let(:source_file) { "#{Dir.pwd}/spec/fixtures/source.json" }
      let(:changes_file) { "#{Dir.pwd}/spec/fixtures/changes.json" }
      let(:io) { double('IO') }

      before do
        ARGV = %W[-s #{source_file} -c #{changes_file}].freeze
        allow(io).to receive(:puts)
        allow_any_instance_of(Highspot::Changer)
          .to receive(:perform)
          .and_return({ my_json: '1' })
        allow(File).to receive(:open).and_yield(io)
      end

      it 'calls changes to apply changes' do
        allow(File).to receive(:open)

        expect_any_instance_of(Highspot::Changer)
          .to receive(:perform)
          .with source: JSON.load_file(source_file, symbolize_names: true),
                changes: JSON.load_file(changes_file, symbolize_names: true)
        subject
      end

      it 'writes output to a file' do
        expect(io).to receive(:puts).with("{\n  \"my_json\": \"1\"\n}")
        subject
      end
    end
  end
end
