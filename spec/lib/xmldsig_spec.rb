require 'spec_helper'

describe Xmldsig do
  let(:private_key) { OpenSSL::PKey::RSA.new(File.read("spec/fixtures/key.pem")) }
  let(:certificate) { OpenSSL::X509::Certificate.new(File.read("spec/fixtures/certificate.cer")) }

  describe "Sign unsigned documents" do
    Dir["spec/fixtures/unsigned/*.xml"].each do |document|
      describe "#{document}" do
        let(:unsigned_xml) { File.read(document) }
        let(:unsigned_document) { Xmldsig::SignedDocument.new(unsigned_xml) }

        it "should be signable an validateable" do
          signed_document = unsigned_document.sign(private_key)
          Xmldsig::SignedDocument.new(signed_document).validate(certificate).should be_true
        end

        it 'should have a signature element' do
          signed_document = unsigned_document.sign(private_key)
          Xmldsig::SignedDocument.new(signed_document).signatures.count.should == 1
        end
      end
    end
  end

  describe "Validate signed documents" do
    Dir["spec/fixtures/signed/*.yml"].each do |document|
      describe "#{document}" do

        it 'verifies the signature' do
          puts YAML.load(document).to_s
        end
      end
    end
  end

end
