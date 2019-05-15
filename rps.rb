class RPS
#make a new instance with the opp strat array passed in
#with rock paper scissors probabilities (ex. [0.3, 0.4, 0.3])
#train the instance however much to populate the regret sum array
#then get_strategy / get_avg_strat
#clear the instance out to train again
#reset the opp_strat if you want with a new array

  #rock paper scissors 1 2 3 
  NUM_ACTIONS = 3

  attr_accessor :regret_sum, :strat_sum, :opp_strat

  def initialize(opp_strat)
    @opp_strat = opp_strat
    @regret_sum = Array.new(NUM_ACTIONS) { 0.0 }
    @strat_sum = Array.new(NUM_ACTIONS) { 0.0 }
  end

  def get_strategy
    norm_sum = 0.0
    strat = Array.new(NUM_ACTIONS) { 0.0 }

    regret_sum.each_with_index do |ele, idx|
      ele > 0 ? strat[idx] = ele : strat[idx] = 0
      norm_sum += strat[idx]
    end

    if norm_sum > 0
      strat.each_with_index do |ele, idx|
        strat[idx] = (ele / norm_sum)
        strat_sum[idx] += strat[idx]
      end
    else
      strat.each_with_index do |ele, idx|
        strat[idx] = 1.0 / NUM_ACTIONS
        strat_sum[idx] += strat[idx]
      end
    end

  strat
  end

  def get_action(strat)
    action = 0
    cumulative_prob = 0.0
    r = rand

    while action < NUM_ACTIONS - 1
      cumulative_prob += strat[action]
      break if r < cumulative_prob
    action += 1
    end

  action 
  end

  def train(iterations)
    action_util = Array.new(NUM_ACTIONS) { 0.0 }

    i = 0
    while i < iterations
      action = get_action(get_strategy)
      opp_action = get_action(opp_strat)

      action_util[opp_action] = 0
      action_util[(opp_action + 1) % NUM_ACTIONS] = 1
      action_util[(opp_action - 1) % NUM_ACTIONS] = -1
      
      regret_sum.each_index do |idx|
        regret_sum[idx] += (action_util[idx] - action_util[action])
      end

    i += 1
    end
  self
  end

  def get_avg_strat
    avg_strat = Array.new(NUM_ACTIONS) { 0.0 }  
    norm_sum = strat_sum.sum

    if norm_sum > 0
      avg_strat.each_index do |idx|
        avg_strat[idx] = strat_sum[idx] / norm_sum
      end
    else
      avg_strat.each_index do |idx|
        avg_strat[idx] = 1.0 / NUM_ACTIONS
      end
    end
  avg_strat
  end

  def clear
    @regret_sum = Array.new(NUM_ACTIONS) { 0.0 }
    @strat_sum = Array.new(NUM_ACTIONS) { 0.0 }
  self
  end

end