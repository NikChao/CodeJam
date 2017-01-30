module ProblemsHelper

def solved?(problem)
    return !Solution.where(problem: problem).where(user: current_user).where(validity: true).blank?
end
end
