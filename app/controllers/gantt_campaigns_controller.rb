class GanttCampaignsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @campaigns = if authorized_user.can_admin_system?
    #   Campaign.active
    # else
    #   current_user.campaigns
    # end

    @items = [{
      start: '2018-11-01',
      end: '2018-11-08',
      name: 'Redesign website',
      id: 'Task 0',
      progress: 50
    },
    {
      start: '2018-11-03',
      end: '2018-11-06',
      name: 'Write new content',
      id: 'Task 1',
      progress: 60,
      dependencies: 'Task 0'
    },
    {
      start: '2018-11-04',
      end: '2018-11-08',
      name: 'Apply new styles',
      id: 'Task 2',
      progress: 10,
      dependencies: 'Task 1'
    },
    {
      start: '2018-11-08',
      end: '2018-11-09',
      name: 'Review',
      id: 'Task 3',
      progress: 5,
      dependencies: 'Task 2'
    },
    {
      start: '2018-11-10',
      end: '2018-11-12',
      name: 'Deploy',
      id: 'Task 4',
      progress: 0
    },
    {
      start: '2018-11-13',
      end: '2018-11-13',
      name: 'Go Live!',
      id: 'Task 5',
      progress: 0,
      dependencies: 'Task 4',
      custom_class: 'bar-milestone'
    },
    {
      start: '2018-11-05',
      end: '2019-01-12',
      name: 'Long term task',
      id: 'Task 6',
      progress: 60
    }]
  end
end
