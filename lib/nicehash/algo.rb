module Nicehash
  module Algo
    ALL = [
      :scrypt,
      :sha256,
      :scryptnf,
      :x11,
      :x13,
      :keccak,
      :x15,
      :nist5,
      :neoscrypt,
      :lyra2re,
      :whirlpoolx,
      :qubit,
      :quark,
      :axiom,
      :lyra2rev2,
      :scryptjanenf16,
      :blake256r8,
      :blake256r14,
      :blake256r8vnl,
      :hodl,
      :daggerhashimoto,
      :decred,
      :cryptonight,
      :lbry,
      :equihash,
      :pascal,
      :x11gost,
      :sia,
      :blake2s,
      :skunk,
      :cryptonightv7,
    ]

    module ModuleMethods
      def all
        ALL
      end

      def from_id(id)
        ALL[id]
      end

      def to_id(algo)
        ALL.find_index(algo)
      end
    end

    extend ModuleMethods
  end
end