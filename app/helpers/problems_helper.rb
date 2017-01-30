module ProblemsHelper

def solved?(problem)
    return !Solution.where(problem: problem).where(user: current_user).where(validity: true).blank?
end

def attempt?(problem)
    return !Solution.where(problem: problem).where(user: current_user).blank?
end

def get_attempt(problem)
    return Solution.where(problem: problem).where(user: current_user).take
end

def get_solution(problem)
    return Solution.where(problem: problem).where(user: current_user).where(validity: true).take
end

end
