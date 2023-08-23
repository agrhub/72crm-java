import Layout from '@/views/layout/projectLayout'
import {
  children
} from './project'

const workbenchRouter = {
  path: '/project',
  component: Layout,
  redirect: '/project/my-task',
  name: 'project',
  meta: {
    icon: 'workbench',
    title: 'Quản lý dự án'
  },
  children: children
}

export default workbenchRouter
