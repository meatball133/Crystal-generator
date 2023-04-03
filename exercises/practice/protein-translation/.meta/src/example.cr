module ProteinTranslation
  extend self

  CODON_TO_PROTEIN = {
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  def proteins(strand : String) : Array(String)
    output = [] of String
    strand.chars.each_slice(3) do |codon|
      if codon.size < 3 || !CODON_TO_PROTEIN.has_key?(codon.join)
        raise ArgumentError.new("Invalid codon: #{codon.join}")
      end
      protein = CODON_TO_PROTEIN[codon.join]
      break if protein == "STOP"
      output << protein
    end

    output
  end
end
