module NucleotideCount
  def self.nucleotide_counts(nucleotides : String) : Hash(Char, Int32)
    raise ArgumentError.new "Invalid nucleotide in strand" unless nucleotides =~ /^[ACGT]+$/ || nucleotides.empty?
    result = {'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0}
    nucleotides.each_char do |nucleotide|
      result[nucleotide] += 1
    end
    result
  end
end
