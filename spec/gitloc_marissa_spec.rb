require 'gitloc_marissa'

RSpec.describe GitlocMarissa do
  it 'raises RepoDoesNotExistError when the repo does not exist' do
    expect { GitlocMarissa.call("not-a-repo") }
      .to raise_error GitlocMarissa::RepoDoesNotExistError, /not-a-repo/
  end
end
