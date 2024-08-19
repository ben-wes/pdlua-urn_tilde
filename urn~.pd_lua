local urn = pd.Class:new():register("urn~")

function urn:initialize(sel, atoms)
  self.inlets = {SIGNAL, SIGNAL}
  self.outlets = {SIGNAL, SIGNAL}
  self:in_1_range(atoms)
  return true
end

function urn:in_1_range(atoms)
  self.count = type(atoms[1]) == "number" and atoms[1] or 1
  self:in_1_reset()
end

function urn:in_1_reset()
  self.deck = {}
  for i = 1, self.count do
    self.deck[i] = i-1
  end
  self.range = self.count
end

function urn:dsp(samplerate, blocksize)
  self.impulse_out = {}
  for i = 1, blocksize do
    self.impulse_out[i] = 0
  end
end

function urn:in_1_seed(atoms)
  local seed = type(atoms[1]) == "number" and atoms[1] or os.time()
  math.randomseed(seed)
end

function urn:perform(in1, in2) -- impulse, seed input
  for i = 1, #in1 do
    self.impulse_out[i] = 0
    if in1[i] == 1 then -- impulse detected
      if self.range == self.count then
        self.impulse_out[i] = 1
        if in2[i] > 0 then -- reseed based on right input if > 0
          math.randomseed(math.floor(in2[i])) -- seed signal input
          self:in_1_reset()
        end
      end
      local rand = math.random(self.range)
      self.held = self.deck[rand]
      in1[i] = self.held
      self.deck[rand] = self.deck[self.range]
      self.deck[self.range] = self.held
      self.range = self.range - 1
      if self.range == 0 then
        self.range = self.count
      end
    else
      in1[i] = self.held
    end
  end
  return in1, self.impulse_out
end
