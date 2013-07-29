module Xmldsig
  class Transforms < Array
    class EnvelopedSignature < Transform
      def transform
        node.xpath("descendant::ds:Signature", Xmldsig::NAMESPACES).first.remove if node.xpath("descendant::ds:Signature", Xmldsig::NAMESPACES).first
        node
      end
    end
  end
end
